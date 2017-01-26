import React    from 'react';
import { Link } from 'react-router';

export default function ApplicationRow(props) {
  return (
    <tr>
      <td><Link to={`/applications/${props.application.id}/application_instances`}>{props.application.name}</Link></td>
      <td><span>{props.application.application_instances_count}</span></td>
    </tr>
  );
}

ApplicationRow.propTypes = {
  application: React.PropTypes.object.isRequired,
};
