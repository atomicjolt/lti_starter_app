import React    from 'react';
import { Link } from 'react-router';

export default function ApplicationRow(props) {
  return (
    <tr>
      <td><Link to={`/instances/${props.id}`}>{props.name}</Link></td>
      <td><span>{props.instances}</span></td>
    </tr>
  );
}

ApplicationRow.propTypes = {
  name: React.PropTypes.string.isRequired,
  id: React.PropTypes.number.isRequired,
  instances: React.PropTypes.number.isRequired,
};
