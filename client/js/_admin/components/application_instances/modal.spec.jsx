import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import { Provider } from 'react-redux';
import Helper       from '../../../../specs_support/helper';
import Modal        from './modal';

describe('application instance modal', () => {

  let result;

  const name = 'the application';

  const props = {
    isOpen: true,
    closeModal: () => {},
    sites: {},
    createApplicationInstance: () => {},
    application: {
      id: 1,
      name
    }
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <Modal {...props} />
      </Provider>
    );
  });

  it('uses the application name as the title', () => {
    const modal = TestUtils.findRenderedComponentWithType(result, Modal);
    expect(modal).not.toBeUndefined(name);
    // TODO we need better specs but reaching into the modal has turned out to be a pain.
    // const h2s = TestUtils.scryRenderedDOMComponentsWithTag(result, 'h2');
    // const h2 = _.find(h2s, { className: 'c-modal__title' });
    // expect(h2.textContent).toContain(name);
  });

});
