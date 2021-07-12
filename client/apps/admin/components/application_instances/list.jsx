import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import ListRow from './list_row';
import Sortable from '../common/sortable';
import Loader from '../../../../common/components/common/atomicjolt_loader';

export default function List(props) {
  const {
    application,
    setSort,
    currentSortColumn,
    currentSortDirection,
    searchChanged,
    isSearchOpen,
    toggleSearch,
    loadingInstances,
    applicationInstances,
  } = props;

  const titles = [
    {
      sortName: 'Name',
      column: 'nickname',
      search: true,
    },
    'Database Tenant', 'Canvas Domain', 'ERRORS',
  ];

  const tableHeader = () => (
    <thead>
      <tr>
        {_.map(titles, (title, key) => {
          if (title.sortName) {
            return (
              <Sortable
                key={`${title.sortName}_${key}`}
                title={title.sortName}
                column={title.column}
                currentColumn={currentSortColumn}
                currentDirection={currentSortDirection}
                setSort={setSort}
                canSearch={title.search}
                searchChanged={searchChanged}
                isSearchOpen={isSearchOpen}
                toggleSearch={toggleSearch}
              />
            );
          }
          return (
            <th key={`${title}_${key}`}>
              <span className="aj-flex">
                {title}
              </span>
            </th>
          );
        })}
      </tr>
    </thead>
  );

  const loader = () => (
    <>
      <table className="c-table c-table--instances">
        {tableHeader()}
      </table>
      <div className="loader-space">
        <Loader />
      </div>
    </>
  );

  return (
    <div className="c-table-container">
      {loadingInstances ? loader() : (
        <table className="c-table c-table--instances">
          {tableHeader()}
          <tbody>
            {
              _.map(applicationInstances, (instance, key) => (
                <ListRow
                  key={`instance_${key}`}
                  application={application}
                  applicationInstance={instance}
                />
              ))
            }
          </tbody>
        </table>
      )}
    </div>
  );
}

List.propTypes = {
  applicationInstances: PropTypes.arrayOf(PropTypes.shape({})).isRequired,
  application: PropTypes.shape({
    key: PropTypes.string,
  }),
  currentSortColumn: PropTypes.string.isRequired,
  currentSortDirection: PropTypes.string.isRequired,
  setSort: PropTypes.func.isRequired,
  searchChanged: PropTypes.func,
  toggleSearch: PropTypes.func,
  isSearchOpen: PropTypes.bool,
  loadingInstances: PropTypes.bool,
};
