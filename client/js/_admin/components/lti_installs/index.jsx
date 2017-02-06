import React                        from 'react';
import { connect }                  from 'react-redux';
import _                            from 'lodash';
import ReactModal                   from 'react-modal';
import appHistory                   from '../../history';
import { getapplications }          from '../../actions/applications';
import { getApplicationInstance }   from '../../actions/application_instances';
import * as AccountActions          from '../../actions/accounts';
import Heading                      from '../common/heading';
import Sidebar                      from './sidebar';
import InstallPane                  from './install_pane';
import canvasRequest                from '../../../libs/canvas/action';
import {
  listActiveCoursesInAccount,
  getSubAccountsOfAccount
} from '../../../libs/canvas/constants/accounts';
import {
  listExternalToolsCourses,
  listExternalToolsAccounts,
  createExternalToolCourses,
} from '../../../libs/canvas/constants/external_tools';

function select(state, props) {
  const instanceId = props.params.applicationInstanceId;

  return {
    applicationInstance : state.applicationInstances[instanceId],
    applications        : state.applications,
    accounts            : state.accounts.accounts,
    loadingAccounts     : state.accounts.loading,
    courses             : _.sortBy(state.courses, course => course.name),
    userName            : state.settings.display_name,
    loadingCourses      : state.loadingCourses,
  };
}

function recursiveGetAccounts(account, canvasReq) {
  if (account.sub_accounts && account.sub_accounts.length === 0) return;

  if (account.sub_accounts === undefined) {
    canvasReq(
      getSubAccountsOfAccount,
      { account_id: account.id },
      null,
      account
    );
  } else {
    _.each(account.sub_accounts, (subAccount) => {
      recursiveGetAccounts(subAccount, canvasReq);
    });
  }
}

export class Home extends React.Component {
  static propTypes = {
    accounts               : React.PropTypes.shape({}).isRequired,
    applications           : React.PropTypes.shape({}).isRequired,
    courses                : React.PropTypes.arrayOf(React.PropTypes.shape({})),
    applicationInstance    : React.PropTypes.shape({}),
    loadingCourses         : React.PropTypes.shape({}),
    loadingAccounts        : React.PropTypes.bool,
    getCanvasAccounts      : React.PropTypes.func.isRequired,
    getApplicationInstance : React.PropTypes.func.isRequired,
    canvasRequest          : React.PropTypes.func.isRequired,
    params                 : React.PropTypes.shape({
      applicationId         : React.PropTypes.string,
      applicationInstanceId : React.PropTypes.string,
    }).isRequired,
  };

  constructor() {
    super();
    this.state = {
      activeAccounts: [],
    };
  }

  componentDidMount() {
    // listExternalToolsCourses
    this.props.getCanvasAccounts();
    this.props.getApplicationInstance(
      this.props.params.applicationId,
      this.props.params.applicationInstanceId
    );
  }

  componentDidUpdate(prevProps) {
    // TODO: this is making a mess
    if (_.isEmpty(prevProps.accounts) && !_.isEmpty(this.props.accounts)) {
      this.props.canvasRequest(
        listExternalToolsAccounts,
        { account_id: 1 },
        null,
        this.props.accounts[1]
      );
    }
    if (!_.isEqual(prevProps.accounts, this.props.accounts)) {
      _.each(
        this.props.accounts,
        account => recursiveGetAccounts(account, this.props.canvasRequest)
      );
    }

    if (_.isEmpty(this.props.courses) && !_.isEmpty(this.props.accounts)) {
      const accountId = this.props.accounts[1].id;
      this.props.canvasRequest(
        listActiveCoursesInAccount,
        { account_id: accountId, per_page: 100 }
      );
    }
  }

  getSubAccountIds(account) {
    let ids = [account.id];
    ids = ids.concat(_.map(account.sub_accounts, subAccount => (
      _.concat(this.getSubAccountIds(subAccount), subAccount.id)
    )));
    return _.flatten(ids);
  }

  setAccountActive(account, depth) {
    const selectedAccount = _.find(
      this.state.activeAccounts,
      activeAccount => (activeAccount.id === account.id)
    );

    if (account.external_tools === undefined) {
      this.props.canvasRequest(
        listExternalToolsAccounts,
        { account_id: account.id },
        null,
        account
      );
    }

    const activeAccounts = _.slice(this.state.activeAccounts, 0, depth);
    if (selectedAccount) {
      this.setState({ activeAccounts });
    } else {
      this.setState({ activeAccounts: activeAccounts.concat(account) });
    }
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
    const applicationInstanceId = parseInt(this.props.params.applicationInstanceId, 10);
    let accountCourses = this.props.courses;
    const lastActiveAccount = _.last(this.state.activeAccounts);

    if (lastActiveAccount) {
      const filterAccountIds = this.getSubAccountIds(lastActiveAccount);

      accountCourses = _.filter(
        this.props.courses,
        course => _.includes(filterAccountIds, course.account_id)
      );
    }

    return (
      <div style={{ height: '100%' }}>
        <Heading back={() => appHistory.goBack()} />
        <div className="o-contain">
          <Sidebar
            accounts={this.props.accounts}
            application={this.props.applications[applicationInstanceId]}
            canvasRequest={this.props.canvasRequest}
            setAccountActive={(account, depth) => this.setAccountActive(account, depth)}
            activeAccounts={this.state.activeAccounts}
          />
          <InstallPane
            canvasRequest={this.props.canvasRequest}
            loadingCourses={this.props.loadingCourses}
            applicationInstance={this.props.applicationInstance}
            courses={accountCourses}
            account={_.last(this.state.activeAccounts) || this.props.accounts[1]}
            loadExternalTools={courseId => this.loadExternalTools(courseId)}
          />
        </div>
        <ReactModal
          isOpen={this.props.loadingAccounts}
          contentLabel="Modal"
          overlayClassName="c-modal__background"
          className="c-modal c-modal--newsite is-open c-modal--error loading"
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
  { getapplications, canvasRequest, getApplicationInstance, ...AccountActions }
)(Home);
