
// Generates the url where the user can go to setup developer keys for the given site
export function canvasDevKeysUrl(site) {
  return `${site.url}/accounts/site_admin/developer_keys`;
}

export function oauthCallbackUrl(applicationInstanceDomain) {
  return `https://${applicationInstanceDomain}/users/auth/canvas/callback`;
}
