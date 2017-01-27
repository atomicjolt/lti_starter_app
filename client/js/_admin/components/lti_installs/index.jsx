import React                 from 'react';
import { connect }           from 'react-redux';
import _                     from 'lodash';
import history               from '../../history';
import { getapplications }   from '../../actions/applications';
import { getCanvasAccounts } from '../../actions/accounts';
<<<<<<< HEAD
import canvasRequest         from '../../../libs/canvas/action';
import Heading               from '../common/heading';
import Sidebar               from './sidebar';
import InstallPane           from './install_pane';
=======
import { listActiveCoursesInAccount } from '../../../libs/canvas/constants/accounts';
import { listExternalToolsCourses } from '../../../libs/canvas/constants/external_tools';
import Header              from '../common/heading';
import Sidebar             from './sidebar';
import InstallPane         from './install_pane';
import canvasRequest       from '../../../libs/canvas/action';
>>>>>>> courses showing and external tools loaded

function select(state) {
  return {
    applications: state.applications,
    accounts: state.accounts,
    courses: state.courses,
    userName: state.settings.display_name,
  };
}

export class Home extends React.Component {
  static propTypes = {
    accounts: React.PropTypes.shape({}).isRequired,
    applications: React.PropTypes.shape({}).isRequired,
    courses: React.PropTypes.shape({}).isRequired,
    userName: React.PropTypes.string.isRequired,
    getCanvasAccounts: React.PropTypes.func.isRequired,
    canvasRequest: React.PropTypes.func.isRequired,
  };

<<<<<<< HEAD
  constructor() {
    super();
    this.state = { account: null };
=======
  constructor(props) {
    super(props);
    this.state = {
      external_tool_run: true,
    };
>>>>>>> courses showing and external tools loaded
  }

  componentDidMount() {
    // listExternalToolsCourses
    this.props.getCanvasAccounts();
  }

<<<<<<< HEAD
=======
  componentDidUpdate() {
    if (_.isEmpty(this.props.courses) && !_.isEmpty(this.props.accounts)) {
      const accountId = this.props.accounts[0].id;
      this.props.canvasRequest(listActiveCoursesInAccount, { account_id: accountId, per_page: 100 });
    }
  }

  getExternalTools() {
    if (this.state.external_tool_run) {
      _.forEach(this.props.courses, course => (
      this.props.canvasRequest(listExternalToolsCourses, { course_id: course.id })
      ));
      this.setState({ external_tool_run: false });
    }
  }

>>>>>>> courses showing and external tools loaded
  render() {
    if (_.isEmpty(this.props.accounts) || _.isEmpty(this.props.courses)) { return null; }
    this.getExternalTools();
    const applicationInstanceId = parseInt(this.props.params.applicationInstanceId);
    return (
      <div style={{ height: '100%' }}>
        <Heading back={() => history.goBack()} />
        <div className="o-contain">
<<<<<<< HEAD
          <Sidebar
            accounts={this.props.accounts}
            application={this.props.applications[2]}
            canvasRequest={this.props.canvasRequest}
            setAccount={account => this.setState({ account })}
            activeAccount={this.state.account}
          />
=======
          <Sidebar accounts={this.props.accounts} application={this.props.applications[applicationInstanceId]} />
>>>>>>> courses showing and external tools loaded
          <InstallPane courses={this.props.courses} accounts={this.props.accounts} />
        </div>
      </div>
    );
  }
}

export default connect(select, { getapplications, getCanvasAccounts, canvasRequest })(Home);
