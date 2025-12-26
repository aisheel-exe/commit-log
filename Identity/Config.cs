using Duende.IdentityServer.Models;

namespace Identity
{
    public static class Config
    {
        public static IEnumerable<IdentityResource> IdentityResources =>
            new IdentityResource[]
            {
                new IdentityResources.OpenId(),
                new IdentityResources.Profile(),
            };

        public static IEnumerable<ApiScope> ApiScopes =>
            new ApiScope[]
            {
                new ApiScope("scope1"),
                new ApiScope("scope2"),
            };

        public static IEnumerable<Client> Clients =>
            new Client[]
            {
                new Client
                {
                    ClientId = "bff-client",
                    ClientSecrets = { new Secret("secret".Sha256()) },


                    AllowedGrantTypes = GrantTypes.Code,

                    RedirectUris = { "https://localhost:5173/signin-oidc" },
                    FrontChannelLogoutUri = "https://localhost:5173/signout-oidc",
                    PostLogoutRedirectUris = { "https://localhost:5173/signout-callback-oidc" },

                    AllowOfflineAccess = true,

                    AllowedScopes = { 
                        "openid", 
                        "profile", 
                        "offline_access"}
                },
            };
    }
}
