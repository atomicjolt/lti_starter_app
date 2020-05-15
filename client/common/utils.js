import _ from 'lodash';

export const canAdmin = (settings, rolesKey = 'admin_roles') => !!_.intersection(
  settings.roles,
  settings[rolesKey],
).length;

export const fixLinks = (html) => {
  const el = document.createElement('div');
  el.innerHTML = html;
  const anchors = el.getElementsByTagName('a');
  _.each(anchors, (anchor) => {
    anchor.setAttribute('target', '_blank');
  });
  return el.innerHTML;
};

export const stripHTML = (text) => {
  const div = document.createElement('div');
  div.innerHTML = text;

  return div.textContent;
};
