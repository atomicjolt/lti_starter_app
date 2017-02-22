import React         from 'react';
import TestUtils     from 'react-addons-test-utils';
import { Provider }  from 'react-redux';
import Helper        from '../../../../specs_support/helper';
import Modal         from './modal';

describe('applications modal', () => {
  let result;
  let props;
  let isShown;
  beforeEach(() => {
    isShown = true;
    props = {
      application: {
        name        : 'SPEC_NAME',
        description : 'SPEC_STRING'
      },
      isOpen: true,
      closeModal: () => { isShown = false; },
      save: () => {}
    };

    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()} >
        <Modal {...props} />
      </Provider>
    );
  });

  it('modal is shown', () => {
    const modal = TestUtils.findRenderedComponentWithType(result, Modal);
    expect(modal).toBeDefined();
    expect(modal.props.isOpen).toBeTruthy();
  });

  it('modal is hidden', () => {
    const modal = TestUtils.findRenderedComponentWithType(result, Modal);
    expect(modal).toBeDefined();
    modal.props.closeModal();
    expect(isShown).toBeFalsy();
  });
});
