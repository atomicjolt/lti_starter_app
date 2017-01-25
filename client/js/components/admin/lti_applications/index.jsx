import React                       from 'react';
import { connect }                 from 'react-redux';
import _                           from 'lodash';
import { getInstructureInstances } from '../../../actions/applications';
import Heading                     from '../common/heading';
import ApplicationRow              from './application_row';

function select(state) {
  return {
    ltiApplications: state.ltiApplications,
    userName: state.settings.display_name,
  };
}

export class Home extends React.Component {
  static propTypes = {
    getInstructureInstances: React.PropTypes.func.isRequired,
    ltiApplications: React.PropTypes.shape({}).isRequired,
    userName: React.PropTypes.string,
  };

  componentDidMount() {
    this.props.getInstructureInstances();
  }

  render() {
    const applicationRows = _.map(this.props.ltiApplications, (application, index) => (
      <ApplicationRow
        key={index}
        {...application}
      />
    ));

    return (
      <div>
        <Heading userName={this.props.userName} />
        <div className="o-contain o-contain--full">
          <div className="c-info">
            <div className="c-title">
              <h1>LTI Applications</h1>
            </div>
            <div className="c-search">
              <input type="text" placeholder="Search..." />
              <i className="i-search" />
            </div>
          </div>
          <table className="c-table c-table--lti">
            <thead>
              <tr>
                <th><span>NAME</span></th>
                <th><span>INSTANCES</span></th>
              </tr>
            </thead>
            <tbody>
              { applicationRows }
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}

export default connect(select, { getInstructureInstances })(Home);
