import React                 from 'react';
import { connect }           from 'react-redux';
import _                     from 'lodash';
import ReactModal            from 'react-modal';
import appHistory            from '../../history';
import { getapplications }   from '../../actions/applications';
import * as AccountActions   from '../../actions/accounts';
import {
  listActiveCoursesInAccount,
  getSubAccountsOfAccount
 } from '../../../libs/canvas/constants/accounts';
import { listExternalToolsCourses } from '../../../libs/canvas/constants/external_tools';
import Heading               from '../common/heading';
import Sidebar               from './sidebar';
import InstallPane         from './install_pane';
import canvasRequest       from '../../../libs/canvas/action';

function select(state) {
  return {
    applications: state.applications,
    accounts: state.accounts.accounts,
    loading_accounts: state.accounts.loading,
    courses: _.sortBy(state.courses, course => course.name),
    userName: state.settings.display_name,
  };
}

function recursiveGetAccounts(account, canvasReq) {
  if (account.sub_accounts && account.sub_accounts.length === 0) {
    return;
  }

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
    accounts: React.PropTypes.shape({}).isRequired,
    applications: React.PropTypes.shape({}).isRequired,
    courses: React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired,
    userName: React.PropTypes.string.isRequired,
    getCanvasAccounts: React.PropTypes.func.isRequired,
    canvasRequest: React.PropTypes.func.isRequired,
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
  }

  componentDidUpdate(prevProps) {
    // TODO: this is making a mess
    if (_.isEmpty(prevProps.accounts) && !_.isEmpty(this.props.accounts)) {
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

    if (_.isEmpty(prevProps.courses) && !_.isEmpty(this.props.courses)) {
      this.getExternalTools();
    }
  }

  getExternalTools() {
    // _.forEach(this.props.courses, course => (
    // this.props.canvasRequest(listExternalToolsCourses, { course_id: course.id })
    // ));
  }

  getSubAccountIds(account) {
    let ids = [account.id]
    ids = ids.concat(_.map(account.sub_accounts, (subAccount) => {
      return _.concat(this.getSubAccountIds(subAccount), subAccount.id);
    }));
    return _.flatten(ids);
  }

  setAccountActive(account, depth) {
    const activeIndex = _.findIndex(
      this.state.activeAccounts,
      activeAccount => (activeAccount.id === account.id)
    );
    const activeAccounts = _.slice(this.state.activeAccounts, 0, depth);

    if (activeIndex >= 0) {
      this.setState({ activeAccounts });
    } else {
      this.setState({ activeAccounts: activeAccounts.concat(account) });
    }
  }

  render() {
    const applicationInstanceId = parseInt(this.props.params.applicationInstanceId);
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
          <InstallPane courses={accountCourses} account={this.state.account} />
        </div>
        <ReactModal
          isOpen={this.props.loading_accounts}
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

export default connect(select, { getapplications, canvasRequest, ...AccountActions })(Home);
