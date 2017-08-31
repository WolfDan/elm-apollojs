import ApolloClient, { createNetworkInterface } from 'apollo-client';

const client = new ApolloClient({
  networkInterface: createNetworkInterface({
    uri: 'https://www.graphqlhub.com/graphql',
  }),
});

export default client
