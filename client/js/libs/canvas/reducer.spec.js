import reducer      from './reducer';

describe('canvas reducer', () => {

  describe('initial state', () => {

    it('has no data', () => {
      const state = reducer(undefined, {});
      expect(state).toEqual({});
    });

  });

  describe('get requests - load data', () => {

  });

});
