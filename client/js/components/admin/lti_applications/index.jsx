import React                  from 'react';
import { connect }            from 'react-redux';
import { getLtiApplications } from '../../../actions/lti_applications';
import ApplicationRow         from './application_row';

function select(state) {
  return {
    ltiApplications: state.ltiApplications,
  };
}

export class Home extends React.Component {
  static propTypes = {
    getLtiApplications: React.PropTypes.func.isRequired,
    ltiApplications: React.PropTypes.array,
  }

  componentDidMount() {
    this.props.getLtiApplications();
  }

  render() {
    const applicationRows = _.map(this.props.ltiApplications, (application, index) => {
      return (
        <ApplicationRow
          key={index}
          name={application.name}
          instances={application.instances}
        />
      );
    });

    return (
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
    );
  }
}

export default connect(select, { getLtiApplications })(Home);
