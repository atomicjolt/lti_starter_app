import React      from 'react';
import { Link }   from 'react-router';
import _          from 'lodash';

export default function instance(props) {
  return (
    <tr>
      <td>
        <Link to={`/installs/${props.id}`}>{_.capitalize(_.replace(props.lti_consumer_uri.split('.')[0], 'https://', ''))}</Link>
        <div>{_.replace(props.lti_consumer_uri, 'https://', '')}</div>
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
  lti_consumer_uri: React.PropTypes.string.isRequired,
  lti_key: React.PropTypes.string.isRequired,
  domain: React.PropTypes.string.isRequired,
  id: React.PropTypes.number.isRequired,
};
