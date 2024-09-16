import 'dart:async';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'user.dart';
import 'dart:io';

class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'data.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;
  static final columnId = 'id';

  Future<Database> get database async =>
      _database ??= await initializeDatabase();

  initializeDatabase() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      Directory(await getDatabasesPath()).create(recursive: true);
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      return databaseFactory.openDatabase(
          join(await getDatabasesPath(), 'data.db'),
          options: OpenDatabaseOptions(
              version: 4,
              onCreate: (db, version) async {
                await db.execute(
                    'CREATE TABLE user(id INTEGER, image TEXT, token TEXT, firstname TEXT, lastname TEXT, address TEXT, gender TEXT, nationality TEXT, phone TEXT, email TEXT, identification TEXT, kin TEXT, marital TEXT, account TEXT, deduction TEXT)');
                await db.execute(
                    'CREATE TABLE loan(id INTEGER PRIMARY KEY, name TEXT, email TEXT, principal FLOAT, interest FLOAT, paid FLOAT, balance FLOAT, date DATE, tenure INT, total_loan FLOAT, next_installment FLOAT, next_installment_date TEXT)');
                await db.execute(
                    'CREATE TABLE token(id INTEGER PRIMARY KEY, token TEXT)');
                await db.execute(
                    'CREATE TABLE officer(id INTEGER PRIMARY KEY, image TEXT, name TEXT, email TEXT, phone_number TEXT, whatsapp_number TEXT)');
                await db.execute(
                    'CREATE TABLE saving(id INTEGER PRIMARY KEY, lin FLOAT, balance FLOAT)');
                await db.execute(
                    'CREATE TABLE bank(id INTEGER PRIMARY KEY, name TEXT, account_number TEXT, bank_name TEXT, status TEXT)');
                await db.execute(
                    'CREATE TABLE target(id INTEGER PRIMARY KEY, name TEXT, amountpm FLOAT, howto TEXT, start DATE, end DATE, balance FLOAT, target FLOAT, status TEXT, trans TEXT, interest FLOAT)');
                await db.execute(
                    'CREATE TABLE loanP(id INTEGER PRIMARY KEY, status TEXT, name TEXT, tenureMin INTEGER, tenureMax INTEGER, amountMin FLOAT, amountMax FLOAT, interest INTEGER, schedule TEXT, Ppayoff TEXT, access TEXT, description TEXT, Pimage TEXT, Passet TEXT)');
                await db.execute(
                    'CREATE TABLE investmentAccount(id INTEGER PRIMARY KEY, account TEXT)');
                await db.execute(
                    'CREATE TABLE investment(id INTEGER PRIMARY KEY, balance FLOAT, date DATE, tenure INT, invest_return FLOAT, interest FLOAT)');
                await db.execute(
                    'CREATE TABLE activity(id INTEGER, name TEXT, time Date, reference TEXT, amount FLOAT, activity_type TEXT)');
                await db.execute(
                    'CREATE TABLE trans(id INTEGER, transaction_no TEXT, transaction_name TEXT, transaction_bank TEXT, note TEXT, date DATE, reference TEXT, amount FLOAT, trans_type TEXT, status TEXT, beginning_balance FLOAT, ending_balance FLOAT, charge FLOAT, image TEXT)');
                await db.execute(
                    'CREATE TABLE settings(id INTEGER PRIMARY KEY, mode TEXT, logged TEXT, opened TEXT, autodeduction TEXT, hidebal TEXT, fromText TEXT, toText TEXT, amountText TEXT, narateText TEXT, isincentive TEXT)');
                await db.execute(
                    'CREATE TABLE installment(id INTEGER PRIMARY KEY, date DATE, status TEXT, installment_amount FLOAT, beginning_balance FLOAT, ending_balance FLOAT, interest FLOAT, principal FLOAT, loan_id INT, installment_number INT)');
                await db.execute(
                    'CREATE TABLE beneficiary(id INTEGER PRIMARY KEY, name TEXT, account_number TEXT, image TEXT)');
                await db.execute(
                    'CREATE TABLE notification(id INTEGER, body TEXT, feedtype TEXT, mytime TEXT, status TEXT)');
                await db.execute(
                    'CREATE TABLE plans(id INTEGER, name TEXT, interest FLOAT, eligible TEXT, interest_gain_period TEXT, interest_threshold FLOAT, interest_type TEXT, fees_on_withdrawal FLOAT, savings_fee FLOAT, duration INTEGER, active TEXT, penalty FLOAT, max_amount FLOAT, min_amount FLOAT, withholding_tax FLOAT, interest_destination TEXT, roll_over BOOLEAN)');
                await db.execute('CREATE TABLE is_target(is_target BOOLEAN)');
              },
              onUpgrade: (db, oldVersion, newVersion) async {
                if (oldVersion < 2) {
                  await db.execute(
                      'CREATE TABLE IF NOT EXISTS plans(id INTEGER, name TEXT, interest FLOAT, eligible TEXT, interest_gain_period TEXT, interest_threshold FLOAT, interest_type TEXT, fees_on_withdrawal FLOAT, savings_fee FLOAT, duration INTEGER, active TEXT, penalty FLOAT, max_amount FLOAT, min_amount FLOAT, withholding_tax FLOAT, interest_destination TEXT, roll_over BOOLEAN)');
                }
                if (oldVersion < 4) {
                  await db.execute(
                      'CREATE TABLE IF NOT EXISTS is_target(is_target BOOLEAN)');
                }
              }));
    } else {
      Directory(await getDatabasesPath()).create(recursive: true);
      databaseFactory = databaseFactory;
      return databaseFactory.openDatabase(
          join(await getDatabasesPath(), 'data.db'),
          options: OpenDatabaseOptions(
              version: 4,
              onCreate: (db, version) async {
                await db.execute(
                    'CREATE TABLE user(id INTEGER, image TEXT, token TEXT, firstname TEXT, lastname TEXT, address TEXT, gender TEXT, nationality TEXT, phone TEXT, email TEXT, identification TEXT, kin TEXT, marital TEXT, account TEXT, deduction TEXT)');
                await db.execute(
                    'CREATE TABLE loan(id INTEGER PRIMARY KEY, name TEXT, email TEXT, principal FLOAT, interest FLOAT, paid FLOAT, balance FLOAT, date DATE, tenure INT, total_loan FLOAT, next_installment FLOAT, next_installment_date TEXT)');
                await db.execute(
                    'CREATE TABLE token(id INTEGER PRIMARY KEY, token TEXT)');
                await db.execute(
                    'CREATE TABLE officer(id INTEGER PRIMARY KEY, image TEXT, name TEXT, email TEXT, phone_number TEXT, whatsapp_number TEXT)');
                await db.execute(
                    'CREATE TABLE saving(id INTEGER PRIMARY KEY, lin FLOAT, balance FLOAT)');
                await db.execute(
                    'CREATE TABLE bank(id INTEGER PRIMARY KEY, name TEXT, account_number TEXT, bank_name TEXT, status TEXT)');
                await db.execute(
                    'CREATE TABLE target(id INTEGER PRIMARY KEY, name TEXT, amountpm FLOAT, howto TEXT, start DATE, end DATE, balance FLOAT, target FLOAT, status TEXT, trans TEXT, interest FLOAT)');
                await db.execute(
                    'CREATE TABLE loanP(id INTEGER PRIMARY KEY, status TEXT, name TEXT, tenureMin INTEGER, tenureMax INTEGER, amountMin FLOAT, amountMax FLOAT, interest INTEGER, schedule TEXT, Ppayoff TEXT, access TEXT, description TEXT, Pimage TEXT, Passet TEXT)');
                await db.execute(
                    'CREATE TABLE investmentAccount(id INTEGER PRIMARY KEY, account TEXT)');
                await db.execute(
                    'CREATE TABLE investment(id INTEGER PRIMARY KEY, balance FLOAT, date DATE, tenure INT, invest_return FLOAT, interest FLOAT)');
                await db.execute(
                    'CREATE TABLE activity(id INTEGER, name TEXT, time Date, reference TEXT, amount FLOAT, activity_type TEXT)');
                await db.execute(
                    'CREATE TABLE trans(id INTEGER, transaction_no TEXT, transaction_name TEXT, transaction_bank TEXT, note TEXT, date DATE, reference TEXT, amount FLOAT, trans_type TEXT, status TEXT, beginning_balance FLOAT, ending_balance FLOAT, charge FLOAT, image TEXT)');
                await db.execute(
                    'CREATE TABLE settings(id INTEGER PRIMARY KEY, mode TEXT, logged TEXT, opened TEXT, autodeduction TEXT, hidebal TEXT, fromText TEXT, toText TEXT, amountText TEXT, narateText TEXT, isincentive TEXT)');
                await db.execute(
                    'CREATE TABLE installment(id INTEGER PRIMARY KEY, date DATE, status TEXT, installment_amount FLOAT, beginning_balance FLOAT, ending_balance FLOAT, interest FLOAT, principal FLOAT, loan_id INT, installment_number INT)');
                await db.execute(
                    'CREATE TABLE beneficiary(id INTEGER PRIMARY KEY, name TEXT, account_number TEXT, image TEXT)');
                await db.execute(
                    'CREATE TABLE notification(id INTEGER, body TEXT, feedtype TEXT, mytime TEXT, status TEXT)');
                await db.execute(
                    'CREATE TABLE plans(id INTEGER, name TEXT, interest FLOAT, eligible TEXT, interest_gain_period TEXT, interest_threshold FLOAT, interest_type TEXT, fees_on_withdrawal FLOAT, savings_fee FLOAT, duration INTEGER, active TEXT, penalty FLOAT, max_amount FLOAT, min_amount FLOAT, withholding_tax FLOAT, interest_destination TEXT, roll_over BOOLEAN)');
                await db.execute('CREATE TABLE is_target(is_target BOOLEAN)');
              },
              onUpgrade: (db, oldVersion, newVersion) async {
                if (oldVersion < 2) {
                  await db.execute(
                      'CREATE TABLE IF NOT EXISTS plans(id INTEGER, name TEXT, interest FLOAT, eligible TEXT, interest_gain_period TEXT, interest_threshold FLOAT, interest_type TEXT, fees_on_withdrawal FLOAT, savings_fee FLOAT, duration INTEGER, active TEXT, penalty FLOAT, max_amount FLOAT, min_amount FLOAT, withholding_tax FLOAT, interest_destination TEXT, roll_over BOOLEAN)');
                }
                if (oldVersion < 4) {
                  await db.execute(
                      'CREATE TABLE IF NOT EXISTS is_target(is_target BOOLEAN)');
                }
              }));
    }
  }

  insertUser(User user) async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM user');
    int count = list.length;
    if (count > 0) {
      await db.execute('delete from user');
    }
    var res = await db.insert('user', user.toMap());
    return res;
  }

  makeded(String ded) async {
    final db = await database;
    var res = await db.update('user', {'deduction': ded},
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [1]);
    return res;
  }

  Future<User> getUser() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM user');
    Map user = list[0];
    return User(
      id: user['id'],
      image: user['image'],
      token: user['token'],
      firstname: user['firstname'],
      lastname: user['lastname'],
      address: user['address'],
      gender: user['gender'],
      nationality: user['nationality'],
      phone: user['phone'],
      email: user['email'],
      identification: user['identification'],
      account: user['account'],
      kin: user['kin'],
      marital: user['marital'],
      deduction: user['deduction'],
    );
  }

  insertToken(String token) async {
    final db = await database;
    await db.execute('delete from token');
    var res = await db.insert('token', {'token': token});
    return res;
  }

  insertInvestA(String account) async {
    final db = await database;
    await db.execute('delete from investmentAccount');
    var res = await db.insert('investmentAccount', {'account': account});
    return res;
  }

  Future<dynamic> getInvestA() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM investmentAccount');
    if (loanL.length > 0) {
      dynamic loan = loanL[0];
      return (loan['account']);
    } else {
      return '';
    }
  }

  logoutdb() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM token');
    int count = list.length;
    if (count > 0) {
      dynamic id = list[count - 1]['id'];
      await db.delete('token', where: 'id = ?', whereArgs: [id]);
    }
    await db.update('settings', {'logged': 'False'},
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [1]);
  }

  makelight() async {
    final db = await database;
    await db.update('settings', {'mode': 'Light'},
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [1]);
  }

  makedark() async {
    final db = await database;
    await db.update('settings', {'mode': 'Dark'},
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [1]);
  }

  sethide(String val) async {
    final db = await database;
    await db.update('settings', {'hidebal': val},
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [1]);
  }

  settrans(
    String from,
    String to,
    String amm,
    String nar,
  ) async {
    final db = await database;
    await db.update('settings',
        {'fromText': from, 'toText': to, 'amountText': amm, 'narateText': nar},
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [1]);
  }

  setins(String val) async {
    final db = await database;
    await db.update('settings', {'isincentive': val},
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [1]);
  }

  updateautodec(String set) async {
    final db = await database;
    await db.update('settings', {'autodeduction': set},
        where: '${DatabaseHelper.columnId} = ?', whereArgs: [1]);
  }

  Future<String> getToken() async {
    final db = await database;
    List<Map<String, Object?>> tokenL =
        await db.rawQuery('SELECT * FROM token');
    dynamic token = tokenL[0]['token'];
    return token;
  }

  insertSettings(Map setting) async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM settings');
    int count = list.length;
    if (count > 0) {
      dynamic id = list[count - 1]['id'];
      await db.delete('settings', where: 'id = ?', whereArgs: [id]);
    }
    var res = await db.insert('settings', {
      'id': 1,
      'mode': setting['mode'],
      'logged': setting['logged'],
      'opened': setting['opened']
    });
    return res;
  }

  Future getSettings() async {
    final db = await database;
    List<Map<String, Object?>> tokenL =
        await db.rawQuery('SELECT * FROM settings');
    if (tokenL.length <= 0) {
      return {};
    }
    dynamic token = tokenL[0];
    return token;
  }

  insertBank(Map<String, Object?> bank) async {
    final db = await database;
    await db.execute('delete from bank');

    if (bank['id'] != null) {
      var res = await db.insert(
        'bank',
        bank,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    }
  }

  insertOfficer(Map<String, Object?> officer) async {
    final db = await database;
    await db.execute('delete from officer');

    if (officer['email'] != null) {
      var res = await db.insert(
        'officer',
        officer,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    }
  }

  Future<dynamic> getBank() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM bank');
    if (loanL.length > 0) {
      dynamic loan = loanL[0];
      return (loan);
    } else {
      return {};
    }
  }

  Future<dynamic> getOfficer() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM officer');
    if (loanL.length > 0) {
      dynamic loan = loanL[0];
      return (loan);
    } else {
      return {};
    }
  }

  insertLoanP(List loanP) async {
    final db = await database;
    await db.execute('delete from loanP');
    final batch = db.batch();

    if (loanP.length > 0) {
      for (var loanp in loanP) {
        batch.insert(
          'loanP',
          loanp,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    }
  }

  Future<dynamic> getLoanP() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM loanP');
    if (loanL.length > 0) {
      dynamic loan = loanL;
      return (loan);
    } else {
      return List.empty();
    }
  }

  insertNoti(List noti) async {
    final db = await database;
    await db.execute('delete from notification');
    final batch = db.batch();

    if (noti.length > 0) {
      for (var nott in noti) {
        batch.insert(
          'notification',
          nott,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    }
  }

  insertPlans(List plans) async {
    final db = await database;
    await db.execute('delete from plans');
    final batch = db.batch();
    print(plans);

    if (plans.length > 0) {
      for (var plan in plans) {
        batch.insert(
          'plans',
          plan,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    }
  }

  Future<dynamic> getPlans() async {
    final db = await database;
    List<dynamic> loanL = await db.rawQuery('SELECT * FROM plans');
    if (loanL.length > 0) {
      dynamic loan = loanL;
      return (loan);
    } else {
      return List.empty();
    }
  }

  notiread(int id) async {
    final db = await database;

    await db.update('notification', {'status': 'true'},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<dynamic> getNoti() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM notification');
    if (loanL.length > 0) {
      dynamic loan = loanL;
      return (loan);
    } else {
      return List.empty();
    }
  }

  insertLoan(Map<String, Object?> loan) async {
    final db = await database;
    final batch = db.batch();
    await db.execute('delete from loan');

    await db.execute('delete from installment');

    dynamic installments = loan['loan_installments'];

    loan.removeWhere((key, value) => key == "loan_installments");

    if (loan['id'] != null) {
      batch.insert(
        'loan',
        loan,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.execute('delete from installment');
      for (var installment in installments) {
        batch.insert(
          'installment',
          installment,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    } else {
      return loan;
    }
  }

  Future<dynamic> getLoan() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM loan');
    if (loanL.length > 0) {
      dynamic loan = loanL[0];
      return (loan);
    } else {
      return {'data': 'not found'};
    }
  }

  Future<dynamic> getInstallment() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM installment');
    if (loanL.length > 0) {
      dynamic loan = loanL;
      return (loan);
    } else {
      return List.empty();
    }
  }

  Future<dynamic> getBeneficiary() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM beneficiary');
    if (loanL.length > 0) {
      dynamic loan = loanL;
      return (loan);
    } else {
      return List.empty();
    }
  }

  insertBeneficiary(dynamic bene) async {
    final db = await database;
    final batch = db.batch();
    await db.execute('delete from beneficiary');
    for (var investment in bene) {
      batch.insert(
        'beneficiary',
        investment,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
    return true;
  }

  insertInvest(dynamic invest, dynamic activities) async {
    if (invest == null) {
      return true;
    }
    final db = await database;
    final batch = db.batch();
    await db.execute('delete from investment');
    for (var investment in invest) {
      batch.insert(
        'investment',
        investment,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await db.execute('delete from activity');
    for (var act in activities) {
      batch.insert(
        'activity',
        act,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
    return true;
  }

  insertIsTarget(
    bool is_target,
  ) async {
    final db = await database;
    final batch = db.batch();
    await db.execute('delete from is_target');
    int istarget;
    if (is_target == true) {
      istarget = 1;
    } else {
      istarget = 0;
    }
    batch.insert(
      'is_target',
      {"is_target": istarget},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
    return true;
  }

  Future<dynamic> getIsTarget() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM is_target');
    if (loanL.length > 0) {
      return (loanL[0]["is_target"]);
    } else {
      return false;
    }
  }

  insertSaving(Map<String, Object?> saving, List<dynamic> trans) async {
    final db = await database;
    await db.execute('delete from saving');
    await db.execute('delete from trans');
    await db.execute('delete from target');
    final batch = db.batch();

    dynamic targets = saving['targets'];

    saving.removeWhere((key, value) => key == "targets");

    //var res = await db.execute("INSERT INTO loan (id,name,email,principal,interest,paid,balance,date,tenure,total_loan) VALUES ",);
    if (saving['id'] != null) {
      batch.insert(
        'saving',
        saving,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      for (var installment in trans) {
        batch.insert(
          'trans',
          installment,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      for (var target in targets) {
        batch.insert(
          'target',
          target,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
      return true;
    } else {
      return saving;
    }
  }

  Future<dynamic> getInvestment() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM investment');
    if (loanL.length > 0) {
      return (loanL);
    } else {
      return [];
    }
  }

  Future<dynamic> getActivity() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM activity');
    if (loanL.length > 0) {
      dynamic loan = loanL;
      return (loan);
    } else {
      return [];
    }
  }

  Future<dynamic> getSaving() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM saving');
    if (loanL.length > 0) {
      dynamic loan = loanL[0];
      return (loan);
    } else {
      return {};
    }
  }

  Future<dynamic> getTarget() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM target');
    if (loanL.length > 0) {
      return (loanL);
    } else {
      return List.empty();
    }
  }

  Future<dynamic> getTrans() async {
    final db = await database;
    List<Map> loanL = await db.rawQuery('SELECT * FROM trans');
    if (loanL.length > 0) {
      dynamic loan = loanL;
      return (loan);
    } else {
      return {};
    }
  }

  Future<dynamic> makeAll(
    User user,
    Map<String, Object?> loan,
    Map<String, Object?> saving,
    List<dynamic> trans,
    dynamic invest,
    dynamic activities,
    dynamic bank,
    dynamic loanP,
    String investA,
    dynamic bene,
    List<dynamic> noti,
    dynamic officer,
    dynamic plans,
    bool is_target,
  ) async {
    final db = await database;

    final batch = db.batch();
    final batch2 = db.batch();
    batch.execute('delete from user');
    batch.execute('delete from bank');
    batch.execute('delete from officer');
    batch.execute('delete from target');
    batch.execute('delete from loanP');
    batch.execute('delete from loan');
    batch.execute('delete from installment');
    batch.execute('delete from is_target');

    if (loan['id'] != null) {
      dynamic installments = loan['loan_installments'];
      loan.removeWhere((key, value) => key == "loan_installments");
      batch2.insert(
        'loan',
        loan,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      for (var installment in installments) {
        batch2.insert(
          'installment',
          installment,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    batch.execute('delete from investmentAccount');
    batch2.insert(
      'investmentAccount',
      {'account': investA},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    int istarget;
    if (is_target == true) {
      istarget = 1;
    } else {
      istarget = 0;
    }
    batch2.insert(
      'is_target',
      {"is_target": istarget},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    batch2.insert('user', user.toMap());
    if (bank['id'] != null) {
      batch2.insert('bank', bank);
    }

    if (officer['email'] != null) {
      batch2.insert('officer', officer);
    }

    batch.execute('delete from saving');
    batch.execute('delete from trans');

    await db.execute('delete from beneficiary');
    for (var investment in bene) {
      batch.insert(
        'beneficiary',
        investment,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    if (saving['id'] != null) {
      dynamic targets = saving['targets'];
      saving.removeWhere((key, value) => key == "targets");
      batch2.insert(
        'saving',
        saving,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      for (var tran in trans) {
        batch2.insert(
          'trans',
          tran,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      for (var target in targets) {
        batch2.insert(
          'target',
          target,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    batch.execute('delete from investment');
    batch.execute('delete from activity');

    if (loanP.length > 0) {
      for (var loanp in loanP) {
        batch2.insert(
          'loanP',
          loanp,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    batch.execute('delete from notification');

    if (noti.length > 0) {
      for (var nott in noti) {
        batch2.insert(
          'notification',
          nott,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    batch.execute('delete from plans');

    if (plans.length > 0) {
      for (var plan in plans) {
        batch2.insert(
          'plans',
          plan,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    if (invest != null) {
      for (var investment in invest) {
        batch2.insert(
          'investment',
          investment,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    if (activities != null) {
      for (var act in activities) {
        batch2.insert(
          'activity',
          act,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    await batch.commit(noResult: true);
    await batch2.commit(noResult: true);

    //investment
  }
}
