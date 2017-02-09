import React        from 'react';
import assets       from '../../../libs/assets';

export default function heading(props) {
  const img = assets('./images/atomicjolt.svg');

  return (
    <header className="c-head">
      <div className="c-back">
        {
          props.back ? <button className="c-btn c-btn--back" onClick={props.back}>
            <i className="i-back" />
            Back
          </button> : null
        }
      </div>
      <img className="c-logo" src={img} alt="Atomic Jolt Logo" />
      <ul className="c-user">
        <li>
          <div className="c-username">{props.userName}<i className="i-dropdown" /></div>
        </li>
      </ul>
    </header>
  );
}

heading.propTypes = {
  back: React.PropTypes.func,
  userName: React.PropTypes.string,
};
