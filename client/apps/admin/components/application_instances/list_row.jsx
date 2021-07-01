import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import moment from 'moment';
import { Link } from 'react-router3';

export default class ListRow extends React.Component {
  static propTypes = {
    application: PropTypes.shape({
      key: PropTypes.string.isRequired,
      id: PropTypes.number.isRequired,
    }),
    applicationInstance: PropTypes.shape({
      site: PropTypes.shape({
        url: PropTypes.string,
      }),
      license_end_date: PropTypes.string,
      licensed_users: PropTypes.number,
      trial_users: PropTypes.number,
      free_trial_days_left: PropTypes.number,
      nickname: PropTypes.string,
      primary_contact: PropTypes.string,
      id: PropTypes.number.isRequired,
      lti_key: PropTypes.string.isRequired,
      request_stats: PropTypes.shape({
        day_365_users: PropTypes.number,
        day_1_errors: PropTypes.number,
        day_7_errors: PropTypes.number,
        max_users_month: PropTypes.number,
      }),
    }).isRequired,
    showPaid: PropTypes.bool,
  };

  get rollBarUrl() {
    const { applicationInstance } = this.props;

    // TODO: Get the org name, app name, and number procedurally
    const org = 'AtomicJolt';
    const app = 'ACT';
    const pNumber = '120707';

    const q = encodeURIComponent(
      'select *\n'
      + 'from item_occurrence\n'
      + 'where unix_timestamp() - timestamp between 0 * 60 * 60 * 24 and 1 * 60 * 60 * 24\n'
      + `and tenant = '${applicationInstance.lti_key}'`
    );

    return `https://rollbar.com/${org}/${app}/rql/?projects=${pNumber}&q=${q}&graph_type=line`;
  }

  render() {
    const { applicationInstance, application, showPaid } = this.props;
    const trialEnds = applicationInstance.free_trial_days_left < 0 ? 'Expired' : `${applicationInstance.free_trial_days_left} Days`;
    const licenseEnds = applicationInstance.license_end_date ? moment(applicationInstance.license_end_date).format('MM/DD/YY') : 'Never';

    return (
      <tr>
        <td>
          <Link to={`/applications/${application.id}/application_instances/${applicationInstance.id}/settings`}>
            {applicationInstance.nickname || 'No Nickname'}
          </Link>
          <div>
            {applicationInstance.primary_contact || 'Unknown User' }
          </div>
        </td>
        <td>
          {showPaid ? licenseEnds :  trialEnds}
        </td>
        <td>
          {applicationInstance.lti_key}
        </td>
        <td>
          {_.replace(applicationInstance.site.url, 'https://', '')}
        </td>
        <td>
          {showPaid ? applicationInstance.licensed_users || 0
            : applicationInstance.trial_users || 0}
        </td>
        <td>
          <a href={this.rollBarUrl} tarket="blank">
            <div>d:{applicationInstance.request_stats.day_1_errors}</div>
            <div>w:{applicationInstance.request_stats.day_7_errors}</div>
          </a>
        </td>
      </tr>
    );
  }
}
