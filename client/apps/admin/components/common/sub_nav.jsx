import _ from 'lodash';
import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router3';

export default function SubNav(props) {
  let warning = null;
  const { sites } = props;
  if (_.isEmpty(sites)
    || _.find(sites, (site) => (_.isEmpty(site.oauth_key) || _.isEmpty(site.oauth_secret)))) {
    warning = <span className="c-alert c-alert--danger"> ! Setup Required</span>;
  }

  return (
    <div className="c-subnav">
      <ul>
        <li>
          <Link to="/applications" activeClassName="is-active">LTI Tools</Link>
        </li>
        <li>
          <Link to="/sites" activeClassName="is-active">
            Sites
            {warning}
          </Link>
        </li>
        <li>
          <Link to="/platforms" activeClassName="is-active">
            Platforms
          </Link>
        </li>
      </ul>
    </div>
  );
}

SubNav.propTypes = {
  sites: PropTypes.shape({}).isRequired,
};
