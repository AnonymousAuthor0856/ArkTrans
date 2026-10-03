package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.Divider
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Tab
import androidx.compose.material3.TabRow
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import kotlinx.coroutines.launch

private const val NAME = "206_StudyFocusSplit_en"
private const val UI_TYPE = "Education SplitPane"
private const val STYLE_THEME = "Clay Morph"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"
private const val DENSITY_SPACING = "Medium"
private const val COMPLEXITY = "Pairs TabRow and Pager views to organize study modules alongside dual focus panes and actions."
private const val EXTRA = "Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts."

object AppTokens {
    object Colors {
        val primary = Color(0xFFC08552)
        val secondary = Color(0xFF9BB1C8)
        val tertiary = Color(0xFFE6CFAF)
        val background = Color(0xFFF3EFE6)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE7DDCF)
        val outline = Color(0xFFD4C5B6)
        val success = Color(0xFF6BB187)
        val warning = Color(0xFFE2A458)
        val error = Color(0xFFD66B5D)
        val onPrimary = Color(0xFF2A1C13)
        val onSecondary = Color(0xFF15202B)
        val onTertiary = Color(0xFF2C1F10)
        val onBackground = Color(0xFF261E19)
        val onSurface = Color(0xFF2E251D)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 30.sp, fontWeight = FontWeight.SemiBold, lineHeight = 36.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.Medium, lineHeight = 28.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium, lineHeight = 24.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(12.dp)
        val medium = RoundedCornerShape(16.dp)
        val large = RoundedCornerShape(20.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 32.dp
        val xxxl = 48.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 6.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(4.dp, 10.dp, 4.dp, 0.16f)
        val level3 = ShadowSpec(8.dp, 14.dp, 6.dp, 0.2f)
        val level4 = ShadowSpec(12.dp, 18.dp, 8.dp, 0.24f)
        val level5 = ShadowSpec(16.dp, 22.dp, 10.dp, 0.28f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = androidx.compose.material3.Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineLarge = AppTokens.TypographyTokens.headline,
    titleLarge = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

private val AppShapes = androidx.compose.material3.Shapes(
    small = AppTokens.Shapes.small,
    medium = AppTokens.Shapes.medium,
    large = AppTokens.Shapes.large
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(colorScheme = AppColorScheme, typography = AppTypography, shapes = AppShapes, content = content)
}

data class StudyModule(val name: String, val progress: Int, val summary: String)
data class TaskItem(val title: String, val duration: String)

@OptIn(ExperimentalFoundationApi::class, ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val spacing = AppTokens.Spacing
    val modules = listOf(
        StudyModule("Clay Resonance", 72, "Acoustic prototypes"),
        StudyModule("Material Memory", 54, "Tactile journaling"),
        StudyModule("Morph Lab", 83, "Color blending"),
        StudyModule("Studio Review", 28, "Peer critique")
    )
    val pagerState = rememberPagerState(initialPage = 0, pageCount = { modules.size })
    val scope = rememberCoroutineScope()
    val tasks = listOf(
        TaskItem("Research layering", "45m"),
        TaskItem("Feedback sync", "30m"),
        TaskItem("Practice recall", "20m")
    )
    var focusNote by remember { mutableStateOf("Focus on tone shifts across clay gradients") }
    Scaffold(
        modifier = Modifier.fillMaxSize(),
        containerColor = AppTokens.Colors.background,
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text(text = "Study Focus Split", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface) },
                navigationIcon = {
                    TextButton(onClick = {}) {
                        Text(text = "Back", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                    }
                },
                actions = {
                    TextButton(onClick = {}) {
                        Text(text = "Share", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.secondary)
                    }
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.surface)
            )
        },
        bottomBar = {
            Surface(color = AppTokens.Colors.surface, tonalElevation = AppTokens.ElevationMapping.level2.elevation, shadowElevation = AppTokens.ElevationMapping.level2.elevation) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = spacing.lg, vertical = spacing.sm),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(verticalArrangement = Arrangement.spacedBy(spacing.xs)) {
                        Text(text = "Next checkpoint", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                        Text(text = "12:40 Studio", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface.copy(alpha = 0.8f))
                    }
                    Button(onClick = {}, shape = AppTokens.Shapes.medium) {
                        Text(text = "Launch session", style = AppTokens.TypographyTokens.label)
                    }
                }
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .verticalScroll(rememberScrollState())
                .padding(horizontal = spacing.lg, vertical = spacing.md),
            verticalArrangement = Arrangement.spacedBy(spacing.lg)
        ) {
            TabRow(selectedTabIndex = pagerState.currentPage, containerColor = AppTokens.Colors.surface, contentColor = AppTokens.Colors.onSurface) {
                modules.forEachIndexed { index, module ->
                    Tab(
                        selected = pagerState.currentPage == index,
                        onClick = { scope.launch { pagerState.animateScrollToPage(index) } },
                        text = { Text(text = module.name, style = AppTokens.TypographyTokens.label, color = if (pagerState.currentPage == index) AppTokens.Colors.primary else AppTokens.Colors.onSurface) }
                    )
                }
            }
            HorizontalPager(state = pagerState, modifier = Modifier.height(220.dp)) { page ->
                val module = modules[page]
                Card(
                    shape = AppTokens.Shapes.large,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                    modifier = Modifier.fillMaxWidth()
                ) {
                    Column(modifier = Modifier.padding(spacing.lg), verticalArrangement = Arrangement.spacedBy(spacing.sm)) {
                        Text(text = module.name, style = AppTokens.TypographyTokens.headline, color = AppTokens.Colors.onSurface)
                        Text(text = module.summary, style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface.copy(alpha = 0.8f))
                        Divider(color = AppTokens.Colors.outline)
                        Row(horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier.fillMaxWidth()) {
                            Text(text = "Progress", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                            Text(text = "${module.progress}%", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                        }
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(12.dp)
                                .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.small),
                            contentAlignment = Alignment.CenterStart
                        ) {
                            Box(
                                modifier = Modifier
                                    .fillMaxHeight()
                                    .fillMaxWidth(module.progress / 100f)
                                    .background(AppTokens.Colors.primary, AppTokens.Shapes.small)
                            )
                        }
                        Button(onClick = {}, shape = AppTokens.Shapes.medium) {
                            Text(text = "Review outline", style = AppTokens.TypographyTokens.label)
                        }
                    }
                }
            }
            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(spacing.md)) {
                Card(
                    modifier = Modifier.weight(1f),
                    shape = AppTokens.Shapes.large,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface)
                ) {
                    Column(modifier = Modifier.padding(spacing.md), verticalArrangement = Arrangement.spacedBy(spacing.sm)) {
                        Text(text = "Focus board", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                        tasks.forEach { task ->
                            Column(
                                modifier = Modifier.background(AppTokens.Colors.surfaceVariant.copy(alpha = 0.6f), AppTokens.Shapes.small).padding(spacing.sm),
                                verticalArrangement = Arrangement.spacedBy(spacing.xs)
                            ) {
                                Text(text = task.title, style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface)
                                Text(text = task.duration, style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.secondary)
                            }
                        }
                        Button(onClick = {}, shape = AppTokens.Shapes.medium) {
                            Text(text = "Add checkpoint", style = AppTokens.TypographyTokens.label)
                        }
                    }
                }
                Card(
                    modifier = Modifier.weight(1f),
                    shape = AppTokens.Shapes.large,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surfaceVariant)
                ) {
                    Column(modifier = Modifier.padding(spacing.md), verticalArrangement = Arrangement.spacedBy(spacing.sm)) {
                        Text(text = "Reflection", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                        Surface(
                            color = AppTokens.Colors.surface,
                            shape = AppTokens.Shapes.medium,
                            modifier = Modifier.fillMaxWidth()
                        ) {
                            Text(text = focusNote, style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface, modifier = Modifier.padding(spacing.md))
                        }
                        Button(onClick = { focusNote = "Blend high and low tones before next critique" }, shape = AppTokens.Shapes.medium) {
                            Text(text = "Shuffle note", style = AppTokens.TypographyTokens.label)
                        }
                    }
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            WindowInsetsControllerCompat(window, window.decorView).hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewRoot() {
    AppTheme {
        Surface(color = MaterialTheme.colorScheme.background) {
            RootScreen()
        }
    }
}