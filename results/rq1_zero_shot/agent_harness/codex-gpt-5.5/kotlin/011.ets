const NAME: string = '008_ForumPost_en';
const UI_TYPE: string = 'Social Forum Post';
const STYLE_THEME: string = 'Dark Neon';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#00E5FF';
  static readonly secondary: string = '#FF00AA';
  static readonly tertiary: string = '#76FF03';
  static readonly background: string = '#101024';
  static readonly surface: string = '#1C1C3A';
  static readonly surfaceVariant: string = '#282850';
  static readonly outline: string = '#44446A';
  static readonly success: string = '#00C853';
  static readonly warning: string = '#FFD600';
  static readonly error: string = '#FF1744';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#000000';
  static readonly onTertiary: string = '#000000';
  static readonly onBackground: string = '#E0E0FF';
  static readonly onSurface: string = '#E0E0FF';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class Author {
  name: string;
  avatarColor: string;

  constructor(name: string, avatarColor: string) {
    this.name = name;
    this.avatarColor = avatarColor;
  }
}

class Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id;
    this.author = author;
    this.timestamp = timestamp;
    this.text = text;
    this.votes = votes;
  }
}

class Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author;
    this.timestamp = timestamp;
    this.title = title;
    this.body = body;
    this.votes = votes;
    this.commentCount = commentCount;
  }
}

@Entry
@Component
struct MainActivity {
  @State voteState: number = 1;
  private post: Post = new Post(
    new Author('user/compose_master', AppColors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    1337,
    42
  );
  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', AppColors.secondary), '7h ago', 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', AppColors.primary), '5h ago', 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18),
    new Reply(3, new Author('newbie/coder', AppColors.warning), '2h ago', 'I found it a bit overwhelming at first. Any tips for organizing the file?', 3)
  ];

  @Builder
  TopBar(): void {
    Row() {
      Text('‹')
        .fontSize(28)
        .fontColor(AppColors.primary)
        .width(48)
        .textAlign(TextAlign.Center);
      Blank();
      Text('r/jetpackcompose')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Blank();
      Blank().width(48);
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  AuthorInfo(author: Author, timestamp: string): void {
    Row({ space: AppSpacing.sm }) {
      Stack() {
        Circle().width(24).height(24).fill(author.avatarColor);
        Circle().width(8).height(8).fill('#33000000');
      }
      .width(24)
      .height(24);
      Text(author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor);
      Text(timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.outline);
    }
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  VoteDiamond(active: boolean, color: string, onTap: () => void): void {
    Text('◆')
      .fontSize(24)
      .fontColor(active ? color : AppColors.outline)
      .width(40)
      .height(40)
      .textAlign(TextAlign.Center)
      .onClick(onTap);
  }

  @Builder
  InfoChip(text: string): void {
    Text(text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.outline);
  }

  @Builder
  PostCard(): void {
    Row({ space: AppSpacing.md }) {
      Column({ space: AppSpacing.sm }) {
        this.VoteDiamond(this.voteState === 1, AppColors.secondary, () => {
          this.voteState = this.voteState === 1 ? 0 : 1;
        });
        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface);
        this.VoteDiamond(this.voteState === -1, AppColors.primary, () => {
          this.voteState = this.voteState === -1 ? 0 : -1;
        });
      }
      .alignItems(HorizontalAlign.Center);

      Column({ space: AppSpacing.sm }) {
        this.AuthorInfo(this.post.author, this.post.timestamp);
        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
        Text(this.post.body)
          .fontSize(16)
          .fontColor('#CCE0E0FF');
        Blank().height(AppSpacing.sm);
        Row({ space: AppSpacing.xl }) {
          this.InfoChip(`${this.post.commentCount} Comments`);
          this.InfoChip('Share');
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface);
  }

  @Builder
  ReplyCard(reply: Reply): void {
    Row({ space: AppSpacing.md }) {
      Rect()
        .width(2)
        .height('100%')
        .fill(reply.author.avatarColor)
        .opacity(0.5)
        .radius(2);
      Column({ space: AppSpacing.xs }) {
        this.AuthorInfo(reply.author, reply.timestamp);
        Text(reply.text)
          .fontSize(16)
          .fontColor('#E6E0E0FF');
        Row({ space: AppSpacing.md }) {
          this.InfoChip(`${reply.votes} votes`);
          this.InfoChip('Reply');
        }
        .alignItems(VerticalAlign.Center);
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm });
  }

  @Builder
  BottomBar(): void {
    Row({ space: AppSpacing.md }) {
      Stack() {
        Text('Add a comment...')
          .fontSize(16)
          .fontColor(AppColors.outline);
      }
      .layoutWeight(1)
      .height(48)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(16)
      .alignContent(Alignment.Start);
      Button('POST')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
        .padding(AppSpacing.lg);
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      this.TopBar();
      Scroll() {
        Column() {
          this.PostCard();
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.outline)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm });
          ForEach(this.replies, (reply: Reply) => {
            this.ReplyCard(reply);
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg });
      }
      .layoutWeight(1);
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
