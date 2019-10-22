import 'package:flutter/material.dart';
import 'package:health/languages/all_translations.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  TermsAndConditionsState createState() => TermsAndConditionsState();
}

class TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(allTranslations.text("Terms")),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                "إن اتفاقية الاستخدام هذه وخصوصية الاستخدام ، والشروط والبنود ، وجميع السياسات التي تم نشرها على تطبيق سكر وضعت لحماية وحفظ حقوق مؤسسة تطبيق سكر وكذلك حفظ المستخدم الذي يصل إلى التطبيق بتسجيل أو من دون تسجيل .",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "تم إنشاء الاتفاقية بناء على نظام التعاملات الإلكترونية و تخضع البنود والشروط والأحكام والمنازعات القانونية للقوانين والتشريعات والأنظمة المعمول بها في المملكة العربية السعودية. ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "لكونك مستخدم فإنك توافق على الإلتزام بكل ما يرد بهذه الاتفاقية في حال إستخدامك لتطبيق سكر و يحق التعديل على هذه الإتفاقية في أي وقت وتعتبر ملزمة لجميع الأطراف بعد الإعلان عن التحديث في التطبيق أو في أي وسيلة اخرى. ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "مؤسسة تطبيق سكر هي الجهة المالكة لتطبيق سكر ، مؤسسة سعودية ١٠٠ ٪ مقرها الرئيسي في منطقة الرياض وهي منصة الكترونية تمكن المستخدم (منشئ الحساب الإلكتروني ) من الاستفادة من خدمات التطبيق المتنوعة وفق شروط وضوابط محددة يشار إليها بهذه الاتفاقية . ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "تعريف: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  "المستخدم : هو ( الفرد ) المنشئ للحساب الإلكتروني الذي يصل إلى التطبيق ويستفيد من خدماته بشكل مباشر أو غير مباشر ، ويشار إليه بالعضو أو الطرف الثاني. ",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                  "الطبيب : هو الفرد المتخصص بالمجال الطبي والذي يعيّن من إدارة التطبيق.الحساب الإلكتروني: هو البيانات التي تنشأ أو تحفظ أو ترسل من قبل المستخدم ( منشئ الحساب الإلكتروني ) من خلالها يتم الاستفادة القصوى من خدمات التطبيق.",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                "شروط الاستخدام :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "بصفتك طرف ثاني في هذه الاتفاقية فإنه بموافقتك على الاستفادة من خدمات التطبيق فعليك الإلتزام بما يلي : ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "•	بعدم استخدام أي وسيلة غير شرعية للوصول للإعلانات أو لبيانات المستخدمين الآخرين أو إنتهاك لسياسة وحقوق مؤسسة تطبيق سكر أو الوصول لمحتوى التطبيق أو تجميع وتحصيل معلومات وبيانات تخص تطبيق سكر أو عملاء التطبيق والاستفادة منها بأي شكل من الأشكال أو إعادة نشرها.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "•	بعدم التعرض للسياسات أو السيادات الدولية أو الشخصيات المعتبرة أو أي مناقشات مع الاشخاص او الاطباء التي لا تتعلق بخدمات التطبيق الطبية المشروعة في مؤسسة تطبيق سكر.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "•	بعدم جمع معلومات عن مستخدمي التطبيق الآخرين لأغراض تجارية أو غيرها.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "•	بعدم انتهاك حقوق الطبع والنشر والعلامات التجارية، وبراءات الاختراع، والدعاية وقواعد البيانات أو غيرها من حقوق الملكية أو الفكرية التي تنتمي لمؤسسة تطبيق سكر أو مرخصة لمؤسسة تطبيق سكر .",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                " •	بعدم انتحال صفة مؤسسة تطبيق سكر أو ممثل لها أو موظف فيها أو أي صفة توحي بأنك تابع للمؤسسة ما لم يكون لديك أذن رسمي من المؤسسة.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "إن عدم التزامك بتلك الشروط يمنح مؤسسة تطبيق سكر الحق كاملا بحجب حسابك ومنعك من الوصول للتطبيق دون الحاجة لإخطارك بذلك وأنت هنا تتعهد بعدم العودة لاستخدام التطبيق إلا بعد موافقة التطبيق على ذلك. ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                " إن استخدامك لتطبيق سكر يعني أنك تخولنا في حفظ بياناتك التي قمت بإدخالها بخوادم المؤسسة ولنا حق الإطلاع عليها ومراجعتها. كما أنك توافق على أحقيتنا في مراقبة الرسائل الخاصة عند الحاجة لضمان خلوها من مخالفات اتفاقية الاستخدام ولنا حق التصرف عند الحاجة لذلك. تعتبر تعاميم وقرارات وتوجيهات إدارة ومشرفي التطبيق ملزمة للطرف الثاني بعد إيصالها له عبر الرسائل الخاصة بالتطبيق أو الجوال أو البريد الإلكتروني أو عبر نظام الإشعارات ، وعليه الإلتزام بها والعمل بموجبها. ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "وثيقة الخصوصية وبيان سريّة المعلومات :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "نقدر مخاوفكم واهتمامكم بشأن خصوصية بياناتكم على شبكة الإنترنت ولقد تم إعداد هذه السياسة لمساعدتكم في تفهم طبيعة البيانات التي نقوم بتجميعها منكم عند زيارتكم لتطبيقنا على شبكة الانترنت وكيفية تعاملنا مع هذه البيانات الشخصية. ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "سنحافظ في كافة الأوقات على خصوصية وسرية كافة البيانات الشخصية التي نتحصل عليها ولن يتم إفشاء هذه المعلومات إلا إذا كان ذلك مطلوباً بموجب أي قانون أو عندما نعتقد بحسن نية أن مثل هذا الإجراء سيكون مطلوباً أو مرغوباً فيه للتمشي مع القانون ، أو للدفاع عن أو حماية حقوق الملكية الخاصة بهذا التطبيق أو الجهات المستفيدة منه. ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "التعديلات على سياسة سرية وخصوصية المعلومات نحتفظ بالحق في تعديل بنود وشروط سياسة سرية وخصوصية المعلومات إن لزم الأمر ومتى كان ذلك ملائماً. سيتم تنفيذ التعديلات هنا او على صفحة سياسة الخصوصية الرئيسية وسيتم بصفة مستمرة إخطارك بالبيانات التي حصلنا عليها وكيف سنستخدمها والجهة التي سنقوم بتزويدها بهذه البيانات.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "يمكنكم الاتصال بنا عند الحاجة من خلال الضغط على راسلنا المتوفر في روابط تطبيق من الصفحة الشخصية او مراسلتنا على البريد الالكتروني SukarDM1@Gmail.com . ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "أخيراً إن مخاوفك واهتمامك بشأن سرية وخصوصية البيانات تعتبر مسألة في غاية الأهمية بالنسبة لنا.",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Text("موافق",style: TextStyle(color: Colors.white),),
                ),
                onTap: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ));
  }
}