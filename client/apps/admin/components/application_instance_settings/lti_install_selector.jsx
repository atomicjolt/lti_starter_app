import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import { useSelector, useDispatch } from 'react-redux';

import { getLtiInstallKeys } from '../../actions/lti_install_keys';
import Sortable from '../common/sortable';
import Pagination from '../common/pagination';

function LtiInstallRow(props) {
  const { ltiInstallKey, ltiInstallId, setLtiInstallId } = props;
  const createdAt = new Date(ltiInstallKey.created_at);

  return (
    <tr>
      <td>
        {ltiInstallKey.id}
      </td>
      <td>
        {ltiInstallKey.iss}
      </td>
      <td>
        {ltiInstallKey.clientId}
      </td>
      <td>
        {createdAt.toLocaleDateString()}
        {' '}
        {createdAt.toLocaleTimeString()}
      </td>
      <td>
        {
          ltiInstallId === ltiInstallKey.id
            ? <span className="c-btn c-btn--yellow">Selected</span>
            : <button
              type="button"
              className="c-btn c-btn--yellow"
              onClick={() => setLtiInstallId(ltiInstallKey.id)}
            >
              Select
              </button>
        }
      </td>
    </tr>
  );
}

export default function LtiInstallSelector(props) {
  const {
    applicationId,
    ltiInstallId,
    setLtiInstallId,
  } = props;

  const [page, setPage] = useState();
  const [sortColumn, setSortColumn] = useState('created_at');
  const [sortDirection, setSortDirection] = useState('desc');

  const ltiInstallKeys = ((state) => _.filter(state.ltiInstallKeys.ltiInstallKeys,
    { application_id: parseInt(applicationId, 10) })
  );
  const totalPages = useSelector((state) => state.ltiInstallKeys.totalPages);

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(getLtiInstallKeys(
      applicationId,
      page,
      sortColumn,
      sortDirection,
    ));
  }, [applicationId, page, sortColumn, sortDirection]);

  function setSort(column, direction) {
    setSortColumn(column);
    setSortDirection(direction);
  }

  return (
    <div className="c-input--container">
      <table className="c-table c-table--instances">
        <thead>
          <tr>
            <Sortable
              title="ID"
              column="id"
              currentColumn={sortColumn}
              currentDirection={sortDirection}
              setSort={setSort}
            />
            <Sortable
              title="ISS"
              column="iss"
              currentColumn={sortColumn}
              currentDirection={sortDirection}
              setSort={setSort}
            />
            <Sortable
              title="CLIENT ID"
              column="client_id"
              currentColumn={sortColumn}
              currentDirection={sortDirection}
              setSort={setSort}
            />
            <Sortable
              title="CREATED"
              column="created_at"
              currentColumn={sortColumn}
              currentDirection={sortDirection}
              setSort={setSort}
            />
            <th />
          </tr>
        </thead>
        <tbody>
          {
          _.map(ltiInstallKeys, (ltiInstallKey, key) => (
            <LtiInstallRow
              key={`lti_install_${key}`}
              ltiInstallId={ltiInstallId}
              ltiInstallKey={ltiInstallKey}
              setLtiInstallId={setLtiInstallId}
            />
          ))
        }
        </tbody>
      </table>
      <Pagination
        setPage={(change) => setPage(change)}
        pageCount={totalPages}
        currentPage={page}
        disableInitialCallback
      />
    </div>
  );
}

LtiInstallSelector.propTypes = {
  applicationId: PropTypes.oneOfType([
    PropTypes.number,
    PropTypes.string,
  ]).isRequired,
  ltiInstallId: PropTypes.number,
  setLtiInstallId: PropTypes.func.isRequired,
};
