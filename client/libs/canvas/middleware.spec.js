import canvasRequest          from './action';
import { listAccounts }       from './constants/accounts';
import { listCoursesForUser } from './constants/courses';
import CanvasMiddlware        from './middleware';
import Helper                 from '../../specs_support/helper';

describe('Canvas Middleware', () => {

  Helper.stubAjax();

  it('implements Redux middleware interface', () => {
    const store = { getState: () => {} };
    const middleware = CanvasMiddlware(store);
    const next = () => {};
    const action = middleware(next);

    // api middleware takes one arg
    expect(CanvasMiddlware.length).toBe(1);
    // api middleware must return a function to handle next
    expect(typeof middleware).toBe('function');
    // next handler returned by api middleware must take one argument
    expect(middleware.length).toBe(1);
    // next handler must return a function to handle action
    expect(typeof action).toBe('function');
    // action handler must take one argument
    expect(action.length).toBe(1);
  });

  it('passes action on to next middleware', () => {
    const store = { getState: () => {} };
    const action = {
      type: 'TEST'
    };
    const nextHandler = CanvasMiddlware(store);
    const next = (actionPassed) => {
      expect(actionPassed).toBe(action);
    };
    const actionHandler = nextHandler(next);
    actionHandler(action);
  });

  xit('calls the api library', (done) => {
    const action = canvasRequest(listAccounts);
    const store = Helper.makeStore();
    spyOn(store, 'dispatch');
    const middleware = CanvasMiddlware(store);
    const nextHandler = () => {};
    const actionHandler = middleware(nextHandler);
    actionHandler(action);
    // store.dispatch is called async after the request from
    // the server returns. We mock the server call but the request
    // still appears to be async which means we have to check the result
    // in the next loop. We use setTimeout with 0 to do this.
    setTimeout(() => {
      expect(store.dispatch).toHaveBeenCalled();
      done();
    }, 0);
  });

  it('raises an error if a required parameter is not supplied', () => {
    const action = canvasRequest(listCoursesForUser);
    const store = Helper.makeStore();
    const middleware = CanvasMiddlware(store);
    const nextHandler = () => {};
    const actionHandler = middleware(nextHandler);
    expect(() => { actionHandler(action); }).toThrow(new Error('Missing required parameter(s): user_id'));
  });

  xit('correctly supplies required parameters', (done) => {
    const action = canvasRequest(listCoursesForUser, { user_id: 1 });
    const store = Helper.makeStore();
    spyOn(store, 'dispatch');
    const middleware = CanvasMiddlware(store);
    const nextHandler = () => {};
    const actionHandler = middleware(nextHandler);
    actionHandler(action);
    setTimeout(() => {
      expect(store.dispatch).toHaveBeenCalled();
      done();
    }, 0);
  });

});
