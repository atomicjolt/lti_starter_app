import React    from 'react';
import _        from 'lodash';
import Instance from './instance';

export default class InstanceList extends React.Component {
  static propTypes = {
    instances: React.PropTypes.shape({}).isRequired,
  };

  static deleteInstance() {
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
            _.map(this.props.instances, (instance, key) => (
              <Instance
                key={`instance_${key}`}
                {...instance}
                delete={() => InstanceList.deleteInstance()}
              />
            ))
          }
        </tbody>
      </table>
    );
  }
}
