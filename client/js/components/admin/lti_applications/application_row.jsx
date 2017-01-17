import React    from 'react';
import { Link } from 'react-router';

export default function ApplicationRow(props) {
  return (
    <tr>
      <td><Link to={`/instances/${7}`}>{props.name}</Link></td>
      <td><span>{props.instances}</span></td>
    </tr>
  );
}

ApplicationRow.propTypes = {
  name: React.PropTypes.string.isRequired,
  instances: React.PropTypes.number.isRequired,
};
