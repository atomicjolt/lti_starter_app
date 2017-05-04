import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import SiteRow from './site_row';

const List = (props) => {
  const siteRows = _.map(props.sites, (site, index) => (
    <SiteRow
      key={`site_${index}`}
      site={site}
    />
  ));

  if (_.isEmpty(props.sites)) {
    return <p className="c-alert c-alert--danger">No sites are currently configured. Please add a site.</p>;
  }

  return (
    <table className="c-table c-table--lti">
      <thead>
        <tr>
          <th><span>URL</span></th>
          <th><span>SETTINGS</span></th>
          <th><span>DELETE</span></th>
        </tr>
      </thead>
      <tbody>
        {siteRows}
      </tbody>
    </table>
  );
};

List.propTypes = {
  sites: PropTypes.shape({}).isRequired,
};

export default List;
