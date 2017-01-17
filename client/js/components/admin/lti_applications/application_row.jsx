import React from 'react';

export default function ApplicationRow(props) {
  return (
    <tr>
      <td><a href="">{props.name}</a></td>
      <td><span>{props.instances}</span></td>
    </tr>
  );
}

ApplicationRow.propTypes = {
  name: React.PropTypes.string.isRequired,
  instances: React.PropTypes.number.isRequired,
}
