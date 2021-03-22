import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import ListRow from './list_row';
import Sortable from '../common/sortable';

export default function List(props) {
  const {
    application,
    settings,
    sites,
    saveApplicationInstance,
    deleteApplicationInstance,
    canvasOauthURL,
    disableApplicationInstance,
    setSort,
    currentSortColumn,
    currentSortDirection,
    showPaid,
    searchChanged,
    isSearchOpen,
    toggleSearch,
  } = props;

  const titles = [
    {
      sortName: 'Name',
      column: 'lti_key',
      search: true,
    },
    showPaid ? 'License Ends' : ({
      sortName: 'Trial Ends',
      column: 'trial_ends',
    }),
    'Database Tenant', 'Canvas Domain', showPaid ? 'Licensed Users' : 'Potential Users',
    'Highest Monthly Uniques', 'Uniques in Last 12mo', 'ERRORS', '',
  ];

  return (
    <div className="c-table-container">
      <table className="c-table c-table--instances">
        <thead>
          <tr>
            {_.map(titles, (title, key) => {
              if(title.sortName) {
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
        <tbody>
          {
            _.map(props.applicationInstances, (instance, key) => (
              <ListRow
                key={`instance_${key}`}
                application={application}
                applicationInstance={instance}
                settings={settings}
                sites={sites}
                save={saveApplicationInstance}
                delete={deleteApplicationInstance}
                canvasOauthURL={canvasOauthURL}
                showPaid={showPaid}
                disable={
                  () => {
                    const disabledAt = instance.disabled_at ? null : new Date(Date.now());
                    disableApplicationInstance(instance.application_id, instance.id, disabledAt);
                  }
                }
              />
            ))
          }
        </tbody>
      </table>
    </div>
  );
}

List.propTypes = {
  applicationInstances: PropTypes.arrayOf(PropTypes.shape({})).isRequired,
  settings: PropTypes.shape({}).isRequired,
  sites: PropTypes.shape({}).isRequired,
  application: PropTypes.shape({
    key: PropTypes.string,
  }),
  saveApplicationInstance: PropTypes.func.isRequired,
  deleteApplicationInstance: PropTypes.func.isRequired,
  canvasOauthURL: PropTypes.string.isRequired,
  disableApplicationInstance: PropTypes.func.isRequired,
  currentSortColumn: PropTypes.string.isRequired,
  currentSortDirection: PropTypes.string.isRequired,
  setSort: PropTypes.func.isRequired,
  showPaid: PropTypes.bool,
  searchChanged: PropTypes.func,
  toggleSearch: PropTypes.func,
  isSearchOpen: PropTypes.bool,
};
