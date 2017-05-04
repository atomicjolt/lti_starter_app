import _ from 'lodash';
import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router';


const SubNav = (props) => {
  let warning = '';
  if (_.isEmpty(props.sites) ||
    _.find(props.sites, site => (_.isEmpty(site.oauth_key) || _.isEmpty(site.oauth_secret)))) {
    warning = <span className="c-alert c-alert--danger"> ! Setup Required</span>;
  }

  return (
    <div className="c-subnav">
      <ul>
        <li>
          <Link to="/applications" activeClassName="is-active">LTI Tools</Link>
        </li>
        <li>
          <Link to="/sites" activeClassName="is-active">Sites{warning}</Link>
        </li>
      </ul>
    </div>
  );
};

SubNav.propTypes = {
  sites: PropTypes.shape({}).isRequired,
};

export default SubNav;
