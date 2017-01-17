import React      from 'react';

export default function instance(props) {
  return (
    <tr>
      <td>
        <a href="">{props.name}</a>
        <div>{props.domain}</div>
      </td>
      <td><span>{props.lti_key}</span></td>
      <td><span>{props.domain}</span></td>
      <td><button className="c-delete" onClick={props.delete()}><i className="i-delete" /></button></td>
    </tr>
  );
}

instance.propTypes = {
  delete: React.PropTypes.func.isRequired,
};
