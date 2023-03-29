import _ from 'lodash';
import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { useSelector, useDispatch } from 'react-redux';
import ReactModal from 'react-modal';

import Form from './form';
// import { updateSite, createSite } from '../../actions/sites';
// import { canvasDevKeysUrl } from '../../libs/sites';

export default function Modal(props) {
  const {
    formType,
    closeModal,
    isOpen,
    fields,
    selectedElement,
    saveElement,
  } = props;

  const existing = _.reduce(fields, (acc, cur) => {acc[cur.prop] = true; return acc}, {})
  const initialFieldValues = _.pickBy(_.cloneDeep(selectedElement), (_,k) => existing[k])
  const [inputState, setInputState] = useState(initialFieldValues)

  // const [site, setSite] = useState(siteProps || {});
  // const settings = useSelector((state) => state.settings);

  // const dispatch = useDispatch();

  // const hasUrlError = () => (
  //   site
  //     && site.url
  //     && site.url.length > 8 // Must be longer than just https://
  //     && !_.startsWith(site.url, 'https://')
  // );

  // const setupSite = () => {
  //   const isUpdate = !!(site && site.id);

  //   if (hasUrlError()) {
  //     return;
  //   }

  //   if (isUpdate) {
  //     dispatch(updateSite(site));
  //   } else {
  //     dispatch(createSite(site));
  //   }
  //   closeModal();
  // };

  // const siteChange = (e) => {
  //   setSite(
  //     {
  //       ...site,
  //       [e.target.name]: e.target.value
  //     });
  // };

  // const isUpdate = !!(site && site.id);
  // const verb = isUpdate ? 'Update' : 'New';

  // const callbackUrl = settings.canvas_callback_url;
  // let canvasDevInstructions = 'Add a canvas domain first.';
  // if (site && site.url) {
  //   canvasDevInstructions = (
  //     <div>
  //       <div>
  //         Use the redirect URI:
  //         {' '}
  //         {callbackUrl}
  //       </div>
  //       <div>
  //         <a href={canvasDevKeysUrl(site)} className="c-modal__subtext-link" target="_blank" rel="noopener noreferrer">
  //           Get Canvas Developer Keys Here
  //         </a>
  //       </div>
  //     </div>
  //   );
  // }

  // let urlError = null;
  // if (hasUrlError()) {
  //   urlError = 'Url must begin with "https://"';
  // }  


  return (
    <ReactModal
      isOpen={isOpen}
      onRequestClose={() => closeModal()}
      contentLabel="Modal"
      overlayClassName="unused"
      className="c-modal c-modal--site is-open"
    >
      <h2 className="c-modal__title">
        Domain
      </h2>
      <h3 className="c-modal__subtext">{"" /*canvasDevInstructions*/}</h3>
      <h3 className="c-modal__subtext">{"" /*urlError*/}</h3>
      <Form
        formType={formType}
        selectedElement={inputState}
        onChange={(e) => { setInputState({...inputState,[e.target.name]: e.target.value})}}
        setupSite={() => {}/*setupSite()*/}
        closeModal={() => closeModal()}
        saveElement={() => saveElement(inputState)}
        fields={fields}
      />
    </ReactModal>
  );

}

// SiteModal.propTypes = {
//   site: PropTypes.shape({
//     id: PropTypes.number,
//   }),
//   isOpen: PropTypes.bool.isRequired,
//   closeModal: PropTypes.func.isRequired,
// };
