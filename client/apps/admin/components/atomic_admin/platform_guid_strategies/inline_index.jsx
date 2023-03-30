import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect, useDispatch } from 'react-redux';
import _ from 'lodash';
import Loader from '../../../../../common/components/common/atomicjolt_loader';
import * as PlatformActions from '../../../actions/atomic_admin/lti_platforms';
import * as ApplicationInstanceActions from '../../../actions/application_instances';
import * as PinnedPlatformGuidActions from '../../../actions/atomic_admin/pinned_platform_guids';
import List from '../list';
import Header from './header';

const select = (state) => ({
  platforms: state.platforms,
  pinnedPlatformGuids: state.pinnedPlatformGuids?.pinnedPlatformGuids,
  loading: state.pinnedPlatformGuids?.loading, // TODO look at platforms / instances
  applications: state.applications,
  applicationInstances: state.applicationInstances,
  sites: state.sites,
});

export function Index(props) {

  const {
    platforms,
    loading,
    params,
    pinnedPlatformGuids,
  } = props;

  const dispatch = useDispatch();
  useEffect(() => { props.getPlatforms(); }, []);
  useEffect(() => { props.getPinnedPlatformGuids(params.applicationInstanceId); }, []);

  const platformOptions = _.map(platforms?.platforms, (p) => ({ label: p.iss, value: p.iss }));
  // const applicationOptions = _.map(applications, (a) => ({label: a.name, value: a.id}))

  const fields = () => [
    {
      label: 'Iss', prop: 'iss', field: 'iss', options: platformOptions, showInSummary: true
    },
    {
      label: 'Platform Instance Guid', prop: 'platform_guid', field: 'platform_guid', showInSummary: true
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
              dispatch(props.createPinnedPlatformGuid(data));
            }}
            staticElementFields={{
              application_instance_id: parseInt(params.applicationInstanceId, 10),
              application_id: parseInt(params.applicationId, 10),
            }}
          />
          <List
            fields={fields()}
            elements={pinnedPlatformGuids}
            saveElement={(id, data) => {
              dispatch(props.updatePinnedPlatformGuid(id, data));
            }}
            deleteElement={props.deletePinnedPlatformGuid}
            emptyText="No Platform Instance Guids are  currently configured."
          />
        </div>
      )}
    </div>
  );
}

export default connect(
  select, { ...PlatformActions, ...PinnedPlatformGuidActions, ...ApplicationInstanceActions }
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
