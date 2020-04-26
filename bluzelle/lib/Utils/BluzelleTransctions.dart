import 'package:sacco/sacco.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BluzelleTransactions {
  static var  networkInfo = NetworkInfo( bech32Hrp: "bluzelle", lcdUrl: "http://testnet.public.bluzelle.com:1317", defaultTokenDenom: "ubnt");

  static sendTokens()async {
    var seed = "around buzz diagram captain obtain detail salon mango muffin brother morning jeans display attend knife carry green dwarf vendor hungry fan route pumpkin car";
    final mnemonic = seed.split(" ");
    final wallet = Wallet.derive(mnemonic,  networkInfo);
    var seed2 = "core fatigue rabbit trust soft country kitten energy punch little case mutual old mimic erupt interest voice inner category stand voice speed patient era";
    final mnemonic2 = seed2.split(" ");
    final wallet2 = Wallet.derive(mnemonic2,  networkInfo);
    final message = StdMsg(
      type: "cosmos-sdk/MsgSend",
      value: {
        "from_address": wallet.bech32Address,
        "to_address": wallet2.bech32Address,
        "amount": [
          {"denom": "ubnt", "amount": "100000000"}
        ],
      },
    );
    final stdTx = TxBuilder.buildStdTx(stdMsgs: [message],
    fee: StdFee(gas: "2000000", amount: [StdCoin(denom: "ubnt",amount: "20000000")])
    );
    print(stdTx);

    final signedStdTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    final result = await TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedStdTx,
    );
    if (result.success) {
      print("Tx send successfully. Hash: ${result.hash}");
    } else {
      print("Tx send error: ${result.error.errorMessage}");
    }
  }
  static Future<String> sendDelegation(String amount, String validator)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String seed= prefs.getString("mnemonic");
    final mnemonic = seed.split(" ");
    final wallet = Wallet.derive(mnemonic,  networkInfo);
    final message = StdMsg(
      type: "cosmos-sdk/MsgDelegate",
      value: {
        "amount": {
          "amount": amount,
          "denom": "ubnt"
        },
        "delegator_address": wallet.bech32Address,
        "validator_address": validator
      },
    );
    final stdTx = TxBuilder.buildStdTx(stdMsgs: [message],
        fee: StdFee(gas: "2000000", amount: [StdCoin(denom: "ubnt",amount: "20000000")])
    );
    final signedStdTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    final result = await TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedStdTx,
    );
    if (result.success) {
      print("Tx send successfully. Hash: ${result.hash}");
      return(result.hash);
    } else {
      print("Tx send error: ${result.error.errorMessage}");
    }
  }
  static Future<String>withdrawReward(String delegator, String validator)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String seed= prefs.getString("mnemonic");
    final mnemonic = seed.split(" ");
    final wallet = Wallet.derive(mnemonic,  networkInfo);
    final message = StdMsg(
      type: "cosmos-sdk/MsgWithdrawDelegationReward",
      value: {
        "delegator_address": delegator,
        "validator_address": validator
      }
    );
    final stdTx = TxBuilder.buildStdTx(stdMsgs: [message],
        fee: StdFee(gas: "2000000", amount: [StdCoin(denom: "ubnt",amount: "20000000")])
    );
    final signedStdTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    final result = await TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedStdTx,
    );
    if (result.success) {
      print("Tx send successfully. Hash: ${result.hash}");
      return(result.hash);
    } else {
      print("Tx send error: ${result.error.errorMessage}");
    }
  }
  static Future<String>undelegate(String delegator, String validator, String amount)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String seed= prefs.getString("mnemonic");
    final mnemonic = seed.split(" ");
    final wallet = Wallet.derive(mnemonic,  networkInfo);
    final message = StdMsg(
        type: "cosmos-sdk/MsgUndelegate",
        value: {
          "amount": {
            "amount": amount,
            "denom": "ubnt"
          },
          "delegator_address": delegator,
          "validator_address": validator
        }
    );
    final stdTx = TxBuilder.buildStdTx(stdMsgs: [message],
        fee: StdFee(gas: "2000000", amount: [StdCoin(denom: "ubnt",amount: "20000000")])
    );
    final signedStdTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    final result = await TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedStdTx,
    );
    if (result.success) {
      print("Tx send successfully. Hash: ${result.hash}");
      return(result.hash);
    } else {
      print("Tx send error: ${result.error.errorMessage}");
    }
  }
  static Future<String>redelegate(String srcValidator, String destValidator, String delegator,String amount)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String seed= prefs.getString("mnemonic");
    final mnemonic = seed.split(" ");
    final wallet = Wallet.derive(mnemonic,  networkInfo);
    final message = StdMsg(
        type: "cosmos-sdk/MsgBeginRedelegate",
        value:{
          "amount": {
            "amount": amount,
            "denom": "ubnt"
          },
          "delegator_address": delegator,
          "validator_dst_address": destValidator,
          "validator_src_address": srcValidator
        }
    );
    final stdTx = TxBuilder.buildStdTx(stdMsgs: [message],
        fee: StdFee(gas: "2000000", amount: [StdCoin(denom: "ubnt",amount: "20000000")])
    );
    final signedStdTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    final result = await TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedStdTx,
    );
    if (result.success) {
      print("Tx send successfully. Hash: ${result.hash}");
      return(result.hash);
    } else {
      print("Tx send error: ${result.error.errorMessage}");
    }
  }
  static Future<String>newProposal(String description, String title, String stake)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String seed= prefs.getString("mnemonic");
    final mnemonic = seed.split(" ");
    final wallet = Wallet.derive(mnemonic,  networkInfo);
    final message = StdMsg(
        type: "cosmos-sdk/MsgSubmitProposal",
        value:{
          "title": "$title",
          "description": "$description",
          "initial_deposit": [
            {
              "amount": stake,
              "denom": "ubnt"
            }
          ],
          "proposal_type": "text",
          "from": wallet.bech32Address  ,
          "proposer": wallet.bech32Address
        }
    );
    final stdTx = TxBuilder.buildStdTx(stdMsgs: [message],
        fee: StdFee(gas: "2000000", amount: [StdCoin(denom: "ubnt",amount: "20000000")])
    );

    final signedStdTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    print(signedStdTx.toJson());
    final result = await TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedStdTx,
    );
    if (result.success) {
      print("Tx send successfully. Hash: ${result.hash}");
      return(result.hash);
    } else {
      print("Tx send error: ${result.error.errorMessage}");
    }
  }
}