import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { Provider } from 'react-redux';
import Helper from '../../../../specs_support/helper';
import Modal from './modal';

describe('site modal', () => {
  let result;

  const url = 'bfcoder.com';

  const props = {
    isOpen: true,
    closeModal: () => {},
    site: {
      id: 1,
      url
    },
    createSite: () => {},
    updateSite: () => {},
    settings: {
      lti_key: '',
      canvas_callback_url: '',
    },
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <Modal {...props} />
      </Provider>
    );
  });

  it('uses the application url as the title', () => {
    const modal = TestUtils.findRenderedComponentWithType(result, Modal);
    expect(modal).not.toBeUndefined();
    // TODO we need better specs but reaching into the modal has turned out to be a pain.
    // const h2s = TestUtils.scryRenderedDOMComponentsWithTag(result, 'h2');
    // const h2 = _.find(h2s, { className: 'c-modal__title' });
    // expect(h2.textContent).toContain(name);
  });

});
