import React    from 'react';
import _        from 'lodash';
import ListRow from './list_row';

export default function List(props) {
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
          _.map(props.applicationInstances, (instance, key) => (
            <ListRow
              key={`instance_${key}`}
              {...instance}
              settings={props.settings}
              delete={props.deleteApplicationInstance}
            />
          ))
        }
      </tbody>
    </table>
  );
}

List.propTypes = {
  applicationInstances: React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired,
  // settings: React.PropTypes.shape({}).isRequired,
  deleteApplicationInstance: React.PropTypes.func.isRequired,
};
