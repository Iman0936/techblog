import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/models/data_models.dart';

Map homePagePosterMap = {
  "imageAsset": Assets.images.posterTest.path,
  "writer": "ایمان خراسانی",
  "date": "یک روز پیش",
  "title": "دوازده قدم برنامه نویسی یک دوره",
  "view": "251",
};

List<HashTagModel> tagList = [
  HashTagModel(title: "جاوا"),
  HashTagModel(title: "کاتلین"),
  HashTagModel(title: "وب"),
  HashTagModel(title: "هوش مصنوعی"),
  HashTagModel(title: "IOT"),
  HashTagModel(title: "دارت"),
];

List<HashTagModel> selectedTags = [];

List<BlogModel> blogList = [
  BlogModel(
    id: 1,
    imageUrl:
        "https://digiato.com/wp-content/uploads/2022/04/photo_2022-04-29_09-37-59.jpg",
    title: "ایلان ماسک حدود 4 میلیارد دلار از سهام تسلا را فروخت",
    writer: "جواد تاجی",
    writerImageUrl: "https://digiato.com/wp-content/uploads/2021/02/1-30.jpg",
    date: "۹ اردیبهشت ۱۴۰۱",
    content:
        """بر اساس اسناد و پرونده‌های نظارتی منتشر شده، «ایلان ماسک» مدیرعامل تسلا، حدود 4.4 میلیون سهام خود از غول خودروسازی را به ارزش 4 میلیارد دلار در روز سه‌شنبه فروخته است.طبق گزارش‌های منتشر شده، ماسک در مجموع پنج فرم 4 را به کمیسیون بورس و اوراق بهادار ایالات متحده (SEC) ارائه کرده که تمام 138 تراکنش فردی او را پوشش می‌دهد.""",
    views: "256",
  ),
  BlogModel(
    id: 2,
    imageUrl:
        "https://static.digiato.com/digiato/2025/09/best-stuff-announced-at-ifa-2025-16-910x600.jpeg",
    title:
        "برترین‌ محصولات IFA 2025؛ از لپ‌تاپ با صفحه چرخان تا ربات‌های مجهز به هوش مصنوعی",
    writer: "آزاد کبیری",
    writerImageUrl:
        "https://digiato.com/wp-content/uploads/avatars/290164-32x32.jpeg",
    date: "۱۶ شهریور ۱۴۰۴",
    content:
        """چند روز پیش درهای بزرگ‌ترین نمایشگاه فناوری اروپا، IFA 2025، رسماً در برلین به روی بازدیدکنندگان باز شد و در این مدت شاهد معرفی گجت‌ها، فناوری و نوآوری‌های جدیدی بودیم که برخی از آنها بسیار خلاقانه و جالب توجه بودند. در ادامه به برترین محصولاتی که در IFA 2025 معرفی شدند، نگاهی می‌اندازیم.""",
    views: "642",
  ),
  BlogModel(
    id: 3,
    imageUrl:
        "https://static.digiato.com/digiato/2025/09/IMG_20250907_211705-910x600.jpg",
    title: "مخارج انتقالی تپسی؛ سودسازی غیرواقعی یا سرمایه‌گذاری آینده‌نگر؟",
    writer: "مجید غنی‌پور",
    writerImageUrl:
        "https://digiato.com/wp-content/uploads/avatars/363219-1757144057-32x32.jpg",
    date: "۱۶ شهریور ۱۴۰۴",
    content:
        """آیا تپسی با سرمایه‌ای کردن هزینه‌های جذب راننده و مسافر تصویری غیرواقعی از سود می‌سازد یا برای ارزش‌آفرینی آینده مسیر درستی را در پیش گرفته است؟ «مجید غنی‌پور»، مشاور مالی و سرمایه‌گذاری در یادداشتی که در اختیار دیجیاتو قرار داده، پاسخ منتقدانی که این سیاست را خلاف استانداردهای حسابداری می‌دانند را می‌دهد. او معتقد است با توجه به ضعف‌های زیرساختی در حمل‌و‌نقل عمومی، تصمیم تپسی برای کپیتالایز کردن هزینه‌ها غیرمنطقی نیست و در آینده از فواید آن بهره‌مند خواهد شد.""",
    views: "268",
  ),
  BlogModel(
    id: 4,
    imageUrl:
        "https://static.digiato.com/digiato/2025/09/web-picture-2-910x600.jpg",
    title: "تبعیض نظارتی میان شرکت‌های بیمه آنلاین و سنتی برطرف می‌شود",
    writer: "الیاس براهوئی‌نژاد",
    writerImageUrl:
        "https://digiato.com/wp-content/uploads/avatars/284254-1748086038-32x32.png",
    date: "۱۶ شهریور ۱۴۰۴",
    content:
        """«احسان چیت‌ساز»، معاون وزیر ارتباطات، در شبکه اجتماعی ایکس نوشت: «با مصوبه کمیته تسهیل فعالیت کسب‌وکارهای اقتصاد دیجیتال، صراحتاً مقرر شد ظرف مدت ۲ ماه، هرگونه تبعیض نظارتی میان شرکت‌های بیمه برخط و سنتی برطرف شود.»""",
    views: "952",
  ),
  BlogModel(
    id: 5,
    imageUrl:
        "https://static.digiato.com/digiato/2025/09/Apple-Intelligence-china-910x600.jpg",
    title: "اپل اینتلیجنس احتمالاً تا پایان سال 2025 در چین فعال می‌شود",
    writer: "مهدی فروغی",
    writerImageUrl:
        "https://digiato.com/wp-content/uploads/avatars/353341-1749323231-32x32.jpg",
    date: "۱۶ شهریور ۱۴۰۴",
    content:
        """براساس گزارش بلومبرگ، عرضه Apple Intelligence در چین که تاکنون به تأخیر افتاده بود، احتمالاً هم‌زمان با انتشار اولین به‌روزرسانی‌های iOS 26 آغاز خواهد شد.

هدف اپل این است که این فناوری را به یکی از قابلیت‌های مهم آیفون برای جلب توجه کاربران تبدیل کند. برای راه‌اندازی Apple Intelligence در چین، اپل نیاز به تأییدیه‌های قانونی دارد که به‌طور معمول مستلزم همکاری با یک شرکت محلی است. فرایند دریافت این مجوزها پیچیده و طولانی است، اما گزارش‌ها نشان می‌دهند که اپل با شرکت‌های چینی مانند Baidu و علی‌بابا وارد همکاری شده است.""",
    views: "437",
  ),
  BlogModel(
    id: 6,
    imageUrl:
        "https://static.digiato.com/digiato/2025/09/Apple-Intelligence-Privacy-910x600.jpg",
    title:
        "بلومبرگ: موتور پاسخگویی هوش مصنوعی اپل زودتر از انتظار از راه می‌رسد",
    writer: "آزاد کبیری",
    writerImageUrl:
        "https://digiato.com/wp-content/uploads/avatars/290164-32x32.jpeg",
    date: "۱۶ شهریور ۱۴۰۴",
    content:
        """به نظر می‌رسد اپل قصد دارد با سرعتی فراتر از انتظار وارد رقابت مستقیم با چت‌بات‌های هوش مصنوعی مانند Perplexity و ChatGPT شود. براساس جدیدترین گزارش‌ها، ابزار جستجوی هوش مصنوعی داخلی و جدید اپل که با نام رمز «World Knowledge Answers» یا WKA شناخته می‌شود، ممکن است در ماه مارس ۲۰۲۶ (اسفندماه ۱۴۰۴) به عنوان بخشی از سیری پیشرفته‌تر عرضه شود.

براساس گزارش مارک گرمن، خبرنگار بلومبرگ، تیم تازه‌تأسیس «پاسخ‌ها، دانش و اطلاعات» اپل با سرعت بالایی درحال پیشبرد پروژه جدید موتور پاسخگویی هوش مصنوعی است. اپل در چند وقت اخیر مشکلات زیادی پیرامون Apple Intelligence و سیری داشته است، اما گویا تیم جدید عزم جدی دارد تا با قدرت وارد فضای رقابتی هوش مصنوعی مولد شود. البته هنور مشخص نیست دقیقاً عملکرد این موتور پاسخگویی چگونه خواهد بود.""",
    views: "347",
  ),
];

List<PodcastModel> podcastList = [
  PodcastModel(
    id: 1,
    imageUrl:
        "https://radioparseh.com/wp-content/uploads/2024/05/20240413_WBD000-1-910x600-1-260x260.jpg",
    title:
        "چالش‌های زیست‌محیطی در توسعه هوش مصنوعی؛ آینده این فناوری در گرو تأمین انرژی",
  ),
  PodcastModel(
    id: 2,
    imageUrl:
        "https://radioparseh.com/wp-content/uploads/2024/05/000-1-910x600-1-260x260.jpg",
    title:
        "چگونه در لینکدین کار پیدا کنیم؟ نکاتی که باعث افزایش شانس شما در استخدام می‌شوند",
  ),
  PodcastModel(
    id: 3,
    imageUrl:
        "https://radioparseh.com/wp-content/uploads/2024/05/Elon-Musk-2-910x600-1-260x260.jpg",
    title:
        "روتین روزانه ایلان ماسک چگونه است؟ خوابیدن در ۳ بامداد و توجه ویژه به دوش‌گرفتن",
  ),
  PodcastModel(
    id: 4,
    imageUrl:
        "https://radioparseh.com/wp-content/uploads/2024/05/photo_2024-03-23_18-45-12-840x600-1-260x260.jpg",
    title: "«سینا تمدن»؛ معاون ارشد شرکت اپل بعد از «استیو جابز»",
  ),
  PodcastModel(
    id: 5,
    imageUrl:
        "https://radioparseh.com/wp-content/uploads/2024/01/100-260x260.jpg",
    title: "مهندسی بی‌نهایت: ایستگاه فضایی بین‌المللی",
  ),
  PodcastModel(
    id: 6,
    imageUrl:
        "https://radioparseh.com/wp-content/uploads/2024/01/25-260x260.jpg",
    title:
        "از کاوش ماه تا بازگشت به زهره؛ با جذاب‌ترین ماموریت‌های فضایی ۲۰۲۴ آشنا شوید",
  ),
];
