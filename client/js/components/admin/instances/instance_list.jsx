import React    from 'react';
import _        from 'lodash';
import Instance from './instance'

export default class InstanceList extends React.Component {
  static propTypes = {

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
            _.map(this.props.instances, instance => (
              <Instance
                {...instance}
                delete={() => this.deleteInstance()}
              />
            ))
          }
        </tbody>
      </table>
    );
  }
}
