import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import ListRow from './list_row';

export default function List(props) {
  return (
    <table className="c-table c-table--instances">
      <thead>
        <tr>
          <th><span>INSTANCE</span></th>
          <th><span>LTI KEY</span></th>
          <th><span>DOMAIN</span></th>
          <th><span>SETTINGS</span></th>
          <th><span>CONFIG XML</span></th>
          <th />
        </tr>
      </thead>
      <tbody>
        {
          _.map(props.applicationInstances, (instance, key) => (
            <ListRow
              key={`instance_${key}`}
              {...instance}
              application={props.application}
              applicationInstance={instance}
              settings={props.settings}
              sites={props.sites}
              save={props.saveApplicationInstance}
              delete={props.deleteApplicationInstance}
              canvasOauthURL={props.canvasOauthURL}
            />
          ))
        }
      </tbody>
    </table>
  );
}

List.propTypes = {
  applicationInstances: PropTypes.arrayOf(PropTypes.shape({})).isRequired,
  settings: PropTypes.shape({}).isRequired,
  sites: PropTypes.shape({}).isRequired,
  application: PropTypes.shape({}),
  saveApplicationInstance: PropTypes.func.isRequired,
  deleteApplicationInstance: PropTypes.func.isRequired,
  canvasOauthURL: PropTypes.string.isRequired,
};
