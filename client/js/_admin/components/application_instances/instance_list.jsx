import React    from 'react';
import _        from 'lodash';
import Instance from './instance';

export default class InstanceList extends React.Component {
  static propTypes = {
    applicationInstances: React.PropTypes.shape({}).isRequired,
    settings: React.PropTypes.shape({}).isRequired,
  };

  deleteInstance() {
    // TODO : Write Me!
  }

  render() {
    return (
      <table className="c-table c-table--instances">
        <thead>
          <tr>
            <th><span>INSTANCE</span></th>
            <th><span>LTI KEY</span></th>
            <th><span>DOMAIN</span></th>
            <th />
          </tr>
        </thead>
        <tbody>
          {
            _.map(this.props.applicationInstances, (instance, key) => (
              <Instance
                key={`instance_${key}`}
                {...instance}
                settings={this.props.settings}
                delete={() => this.deleteInstance()}
              />
            ))
          }
        </tbody>
      </table>
    );
  }
}
