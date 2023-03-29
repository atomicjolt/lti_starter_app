import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import Loader from '../../../../../common/components/common/atomicjolt_loader';
import * as PlatformActions from '../../../actions/atomic_admin/lti_platforms';
import * as ApplicationInstanceActions from '../../../actions/application_instances';
import * as PinnedClientIdActions from '../../../actions/atomic_admin/pinned_client_ids';
import List from '../list';
import Header from './header';

const select = (state) => ({
  platforms: state.platforms,
  pinnedClientIds: state.pinnedClientIds?.pinnedClientIds,
  loading: state.pinnedClientIds?.loading,
  applications: state.applications,
  applicationInstances: state.applicationInstances,
  sites: state.sites,
});

export function Index(props) {

  const {
    platforms,
    loading,
    params,
    pinnedClientIds,
  } = props;

  useEffect(() => { props.getPlatforms(); }, []);
  useEffect(() => { props.getPinnedClientIds(params.applicationInstanceId); }, []);

  const issOptions = _.map(platforms?.platforms, (p) => ({ label: p.iss, value: p.iss }));
  // const applicationOptions = _.map(applications, (a) => ({label: a.name, value: a.id}))

  const fields = () => [
    {
      label: 'Iss', prop: 'iss', field: 'iss', options: issOptions, showInSummary: true
    },
    {
      label: 'Client ID', prop: 'client_id', field: 'client_id', showInSummary: true
    },
  ];

  const renderLoading = () => (
    <div className="aj-loading-space-top">
      <Loader />
    </div>
  );

  return (
    <div>

      {loading ? renderLoading() : (
        <div className="__aj-admin-container">
          <Header
            fields={fields()}
            saveElement={(data) => {
              props.createPinnedClientId(data);
            }}
            staticElementFields={{
              application_instance_id: parseInt(params.applicationInstanceId, 10),
              application_id: parseInt(params.applicationId, 10),
            }}
          />
          <List
            fields={fields()}
            elements={pinnedClientIds}
            saveElement={(id, data) => {
              props.updatePinnedClientId(id, data);
            }}
            deleteElement={props.deletePinnedClientId}
            emptyText="No Client Ids are  currently configured."
          />
        </div>
      )}
    </div>
  );
}

export default connect(
  select, { ...PlatformActions, ...PinnedClientIdActions, ...ApplicationInstanceActions }
)(Index);
// export default Index

// Index.propTypes = {
//   params: PropTypes.shape({
//     applicationId: PropTypes.string.isRequired,
//     applicationInstanceId: PropTypes.string.isRequired,
//   }).isRequired,
//   applications: PropTypes.shape({}).isRequired,
//   getApplicationInstance: PropTypes.func,
//   applicationInstances: PropTypes.array,
//   router: PropTypes.shape({
//     push: PropTypes.func,
//   }),
//   loading: PropTypes.bool,
//   sites: PropTypes.shape({}).isRequired,
//   deleteApplicationInstance: PropTypes.func,
//   disableApplicationInstance: PropTypes.func,
//   children: PropTypes.element,
//   location: PropTypes.shape({}),
// };
