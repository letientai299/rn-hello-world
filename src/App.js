import React from "react";
import Hyperlink from "react-native-hyperlink";
import { Platform, StyleSheet, Text, View } from "react-native";

const instructions =
  Platform.select({
    ios: "You are on iOS.\n",
    android: "You are on Android\n"
  }) +
  "\nFor the source code of this app, please visit\nhttps://github.com/letientai299/rn-hello-world";

type Props = {};
export default class App extends React.Component<Props> {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome!</Text>
        <Hyperlink linkStyle={styles.link} linkDefault={true}>
          <Text style={styles.instructions}>{instructions}</Text>
        </Hyperlink>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#F5FCFF"
  },
  welcome: {
    fontSize: 20,
    textAlign: "center",
    margin: 10
  },
  instructions: {
    textAlign: "center",
    color: "#333333",
    marginBottom: 5
  },
  link: {
    color: "#2980b9"
  }
});
