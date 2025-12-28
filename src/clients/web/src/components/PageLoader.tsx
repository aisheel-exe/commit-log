interface PageLoaderProps {
  label?: string;
}

export function PageLoader({
  label = "Loading...",
}: Readonly<PageLoaderProps>) {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen gap-4">
      <div className="relative">
        <div className="w-8 h-8 rounded-full border-4 border-gray-200" />
        <div
          className=" w-8 h-8 rounded-full border-4 border-blue-300 border-t-transparent absolute top-0 left-0 animate-spin"
          role="status"
          aria-label={label}
        />
      </div>
      {label && <p className=" text-sm text-gray-700 font-medium">{label}</p>}
    </div>
  );
}
