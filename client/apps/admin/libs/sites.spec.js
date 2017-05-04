import { canvasDevKeysUrl } from './sites';

describe('canvasDevKeysUrl', () => {
  it('Generate a url for setting up developer id and key', () => {
    const site = {
      url: 'https://www.example.com'
    };
    const url = canvasDevKeysUrl(site);
    expect(url).toBe(`${site.url}/accounts/site_admin/developer_keys`);
  });

});
