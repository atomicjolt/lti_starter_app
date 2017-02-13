import React               from 'react';
import { connect }         from 'react-redux';
import _                   from 'lodash';
import { saveApplication } from '../../actions/applications';
import Heading             from '../common/heading';
import ApplicationRow      from './application_row';

function select(state) {
  return {
    applications: state.applications,
    userName: state.settings.display_name,
  };
}

export class Index extends React.Component {

  static propTypes = {
    saveApplication: React.PropTypes.func.isRequired,
    applications: React.PropTypes.shape({}).isRequired,
  };

  render() {
    const applicationRows = _.map(this.props.applications, (application, index) => (
      <ApplicationRow
        key={index}
        application={application}
        saveApplication={this.props.saveApplication}
      />
    ));

    return (
      <div>
        <Heading />
        <div className="o-contain o-contain--full">
          <div className="c-info">
            <div className="c-title">
              <h1>LTI Applications</h1>
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

export default connect(select, { saveApplication })(Index);
