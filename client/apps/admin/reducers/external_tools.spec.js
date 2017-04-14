import externalTools from './external_tools';

describe('external_tools reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {};
      const state = externalTools(initialState, {});
      expect(state).toEqual({});
    });
  });

  describe('list external tools accounts', () => {
    it('returns the same state', () => {
      const toolId = 1;
      const state = { external_tools: [{ 1: { id: 1, config: 123 } }] };
      const result = externalTools(state, {
        type: 'LIST_EXTERNAL_TOOLS_ACCOUNTS_DONE',
        original: {
          localData: {
            external_tools: {
              1: { }
            }
          }
        },
        payload: [{ id: toolId }]
      });
      expect(result.external_tools.length).toBe(1);
    });

    it('returns the same state', () => {
      const toolId = 1;
      const state = { external_tools: [{ 1: { id: 1, config: 123 } }] };
      const result = externalTools(state, {
        type: 'LIST_EXTERNAL_TOOLS_ACCOUNTS_DONE',
        original: {
          localData: { }
        },
        payload: [{ id: toolId }]
      });
      expect(result.external_tools.length).toBe(1);
    });
  });

  describe('create external tools accounts', () => {
    it('returns the same state', () => {
      const toolId = 1;
      const state = { external_tools: [{ 1: { id: 1, config: 123 } }] };
      const result = externalTools(state, {
        type: 'CREATE_EXTERNAL_TOOLS_ACCOUNTS_DONE',
        original: {
          localData: {
            external_tools: {
              1: { }
            }
          }
        },
        payload: [{ id: toolId }]
      });
      expect(result.external_tools.length).toBe(1);
    });
  });

  describe('delete external tools accounts', () => {
    it('returns the same state', () => {
      const toolId = 1;
      const state = { external_tools: [{ 1: { id: 1, config: 123 } }] };
      const result = externalTools(state, {
        type: 'DELETE_EXTERNAL_TOOLS_ACCOUNTS_DONE',
        original: {
          localData: {
            external_tools: {
              1: { }
            }
          }
        },
        payload: [{ id: toolId }]
      });
      expect(result.external_tools.length).toBe(1);
    });
  });
});
