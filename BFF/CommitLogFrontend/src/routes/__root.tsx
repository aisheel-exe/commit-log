import { Outlet, createRootRouteWithContext } from "@tanstack/react-router";
import { queryOptions, type QueryClient } from "@tanstack/react-query";
import { bffClient } from "../lib/api/bff-client";
import { isAxiosError } from "axios";
import { PageLoader } from "../components/PageLoader";

interface RouterContext {
  queryClient: QueryClient;
}

const userQueryOptions = queryOptions({
  queryKey: ["user"],
  queryFn: async () => {
    const response = await bffClient("/user");
    return response.data;
  },
  staleTime: 1000 * 60 * 5,
});

export const Route = createRootRouteWithContext<RouterContext>()({
  component: RootComponent,
  beforeLoad: async ({ location, context: { queryClient } }) => {
    const isPublicRoute = location.pathname === "/";

    if (isPublicRoute) {
      return;
    }

    try {
      const response = await queryClient.ensureQueryData(userQueryOptions);
      const user = response.data;

      if (user) {
        return;
      }
    } catch (error) {
      if (isAxiosError(error) && error.status === 401) {
        window.location.href = `/bff/login?returnUrl=${encodeURIComponent(
          location.href
        )}`;

        return new Promise(() => {});
      }

      throw error;
    }
  },
  pendingComponent: () => <PageLoader label="Redirecting to login..." />,
});

function RootComponent() {
  return (
    <main className="h-screen flex items-center justify-center text-4xl font-medium">
      <Outlet />
    </main>
  );
}
