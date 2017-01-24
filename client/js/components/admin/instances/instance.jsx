import React      from 'react';
import { Link }   from 'react-router';
import _          from 'lodash';

export default function instance(props) {
  return (
    <tr>
      <td>
        <Link to={`instances/${props.id}/installs`}>{_.capitalize(_.replace(props.url.split('.')[0], 'https://', ''))}</Link>
        <div>{_.replace(props.url, 'https://', '')}</div>
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
  delete           : React.PropTypes.func.isRequired,
  url              : React.PropTypes.string,
  lti_key          : React.PropTypes.string,
  domain           : React.PropTypes.string,
  id               : React.PropTypes.number.isRequired,
};
