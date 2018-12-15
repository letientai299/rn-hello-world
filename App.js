/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {
  Component
} from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View
} from 'react-native';

const instructions = Platform.select({
    ios: 'You are on iOS.\n',
    android: 'You are on Android\n'
  }) +
  "\nFor the source code of this app, please visit https://github.com/letientai299/rn-hello-world";

type Props = {};
export default class App extends Component < Props > {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome!</Text>
        <Text style={styles.instructions}>{instructions}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
