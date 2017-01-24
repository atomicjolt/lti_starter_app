import React      from 'react';
import { Link }   from 'react-router';
import _          from 'lodash';

export default function instance(props) {
  return (
    <tr>
      <td>
        <Link to={`instances/${props.id}/installs`}>{_.capitalize(_.replace(props.domain.split('.')[1], 'https://', ''))}</Link>
        <div>{_.replace(props.domain, 'https://', '')}</div>
      </td>
      <td><span>{props.lti_key}</span></td>
      <td><span>{props.domain}</span></td>
      <td>
        <button className="c-delete" onClick={props.delete}>
          <i className="i-delete" />
        </button>
      </td>
    </tr>
  );
}

instance.propTypes = {
  delete: React.PropTypes.func.isRequired,
  lti_key: React.PropTypes.string,
  domain: React.PropTypes.string,
  id: React.PropTypes.number.isRequired,
};
