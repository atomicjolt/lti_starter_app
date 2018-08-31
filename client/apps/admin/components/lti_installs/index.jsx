import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import ReactModal from 'react-modal';
import { listActiveCoursesInAccount } from 'atomic-canvas/libs/constants/accounts';
import { listExternalToolsCourses, listExternalToolsAccounts } from 'atomic-canvas/libs/constants/external_tools';
import { helperListAccounts } from 'atomic-canvas/libs/helper_constants';
import canvasRequest from 'atomic-canvas/libs/action';
import * as ApplicationInstanceActions from '../../actions/application_instances';
import Heading from '../common/heading';
import Sidebar from './sidebar';
import InstallPane from './install_pane';


function select(state, props) {
  const instanceId = props.params.applicationInstanceId;

  return {
    applicationInstance: state.applicationInstances.applicationInstances[instanceId],
    applications: state.applications,
    accounts: state.accounts.accounts,
    rootAccount: _.find(state.accounts.accounts, { parent_account_id: null }),
    loadingAccounts: state.accounts.loading,
    courses: _.sortBy(state.courses, course => course.name),
    userName: state.settings.display_name,
    loadingCourses: state.loadingCourses,
    sites: state.sites,
  };
}

export class Index extends React.Component {
  static propTypes = {
    accounts: PropTypes.shape({}).isRequired,
    rootAccount: PropTypes.shape({
      id: PropTypes.number
    }),
    applications: PropTypes.shape({}).isRequired,
    courses: PropTypes.arrayOf(PropTypes.shape({})),
    applicationInstance: PropTypes.shape({}),
    loadingCourses: PropTypes.shape({}),
    loadingAccounts: PropTypes.bool,
    getApplicationInstance: PropTypes.func.isRequired,
    canvasRequest: PropTypes.func.isRequired,
    saveApplicationInstance: PropTypes.func.isRequired,
    params: PropTypes.shape({
      applicationId: PropTypes.string,
      applicationInstanceId: PropTypes.string,
    }).isRequired,
    sites: PropTypes.shape({}).isRequired,
  };

  constructor() {
    super();
    this.state = {
      currentAccount: null,
      onlyShowInstalled: false,
    };
  }

  componentDidMount() {
    this.props.canvasRequest(
      helperListAccounts,
      {},
      null,
      null,
    );
    this.props.getApplicationInstance(
      this.props.params.applicationId,
      this.props.params.applicationInstanceId
    );
  }

  componentWillReceiveProps() {
    if (_.isNull(this.state.currentAccount) && !_.isUndefined(this.props.rootAccount)) {
      this.setAccountActive(this.props.rootAccount);
    }
  }

  componentDidUpdate(prevProps) {
    // TODO: this is making a mess
    if (_.isEmpty(prevProps.accounts) && !_.isEmpty(this.props.accounts)) {
      this.props.canvasRequest(
        listExternalToolsAccounts,
        { account_id: this.props.rootAccount.id },
        null,
        this.props.rootAccount
      );
    }

    if (_.isEmpty(this.props.courses) && !_.isEmpty(this.props.accounts)) {
      this.props.canvasRequest(
        listActiveCoursesInAccount,
        { account_id: this.props.rootAccount.id, per_page: 100 }
      );
    }
  }

  setAccountActive(account) {
    if (account.external_tools === undefined) {
      this.props.canvasRequest(
        listExternalToolsAccounts,
        { account_id: account.id },
        null,
        account
      );
    }

    this.setState({
      currentAccount: account,
    });
  }

  loadExternalTools(courseId) {
    this.props.canvasRequest(
      listExternalToolsCourses,
      { course_id: courseId },
      null,
      courseId,
    );
  }

  render() {
    const applicationId = parseInt(this.props.params.applicationId, 10);
    const backTo = `/applications/${this.props.params.applicationId}/application_instances`;

    return (
      <div style={{ height: '100%' }}>
        <Heading backTo={backTo} />
        <div className="o-contain">
          <Sidebar
            currentAccount={this.state.currentAccount}
            accounts={this.props.accounts}
            application={this.props.applications[applicationId]}
            applicationInstance={this.props.applicationInstance}
            canvasRequest={this.props.canvasRequest}
            setAccountActive={account => this.setAccountActive(account)}
            saveApplicationInstance={this.props.saveApplicationInstance}
            sites={this.props.sites}
          />
          <InstallPane
            canvasRequest={this.props.canvasRequest}
            loadingCourses={this.props.loadingCourses}
            applicationInstance={this.props.applicationInstance}
            account={this.state.currentAccount}
            loadExternalTools={courseId => this.loadExternalTools(courseId)}
          />
        </div>
        <ReactModal
          isOpen={this.props.loadingAccounts}
          contentLabel="Modal"
          overlayClassName="c-modal__background"
          className="c-modal c-modal--site is-open c-modal--error loading"
        >
          <div className="c-loading-icon" />
          &nbsp;&nbsp;&nbsp;Loading...
        </ReactModal>
      </div>
    );
  }
}

export default connect(
  select,
  { canvasRequest, ...ApplicationInstanceActions }
)(Index);
