import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import ListRow from './list_row';
import Sortable from '../common/sortable';

export default function List(props) {
  const {
    application,
    saveLtiInstallKey,
    deleteLtiInstallKey,
    setSort,
    currentSortColumn,
    currentSortDirection,
    ltiInstallKeys,
  } = props;

  return (
    <table className="c-table c-table--instances">
      <thead>
        <tr>
          <th />
          <Sortable
            title="ID"
            column="id"
            currentColumn={currentSortColumn}
            currentDirection={currentSortDirection}
            setSort={setSort}
          />
          <Sortable
            title="ISS"
            column="iss"
            currentColumn={currentSortColumn}
            currentDirection={currentSortDirection}
            setSort={setSort}
          />
          <Sortable
            title="CLIENT ID"
            column="client_id"
            currentColumn={currentSortColumn}
            currentDirection={currentSortDirection}
            setSort={setSort}
          />
          <Sortable
            title="CREATED"
            column="created_at"
            currentColumn={currentSortColumn}
            currentDirection={currentSortDirection}
            setSort={setSort}
          />
          <th />
        </tr>
      </thead>
      <tbody>
        {
          _.map(ltiInstallKeys, (ltiInstallKey, key) => (
            <ListRow
              key={`instance_${key}`}
              application={application}
              ltiInstallKey={ltiInstallKey}
              save={saveLtiInstallKey}
              delete={deleteLtiInstallKey}
            />
          ))
        }
      </tbody>
    </table>
  );
}

List.propTypes = {
  ltiInstallKeys: PropTypes.arrayOf(PropTypes.shape({})).isRequired,
  application: PropTypes.shape({}),
  saveLtiInstallKey: PropTypes.func.isRequired,
  deleteLtiInstallKey: PropTypes.func.isRequired,
  currentSortColumn: PropTypes.string.isRequired,
  currentSortDirection: PropTypes.string.isRequired,
  setSort: PropTypes.func.isRequired,
};
