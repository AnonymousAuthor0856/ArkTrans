package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Tab
import androidx.compose.material3.TabRow
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
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

private const val NAME = "087_StepChallenge_en"
private const val UI_TYPE = "Health ControlPanel"
private const val STYLE_THEME = "Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF111827)
        val secondary = Color(0xFF374151)
        val tertiary = Color(0xFF6B7280)
        val background = Color(0xFFF9FAFB)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE5E7EB)
        val outline = Color(0xFFD1D5DB)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF111827)
        val onBackground = Color(0xFF111827)
        val onSurface = Color(0xFF1F2937)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(16.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 36.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.14f)
        val level3 = ShadowSpec(8.dp, 12.dp, 6.dp, 0.16f)
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

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val tabs = listOf("Overview", "Ranking", "Stats")
    val pagerState = rememberPagerState(pageCount = { tabs.size })
    val coroutine = rememberCoroutineScope()
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .background(
                    Brush.verticalGradient(
                        listOf(AppTokens.Colors.surfaceVariant, AppTokens.Colors.surface)
                    )
                )
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(AppTokens.Spacing.lg),
                contentAlignment = Alignment.Center
            ) {
                Text("Step Challenge", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onBackground)
            }
            TabRow(selectedTabIndex = pagerState.currentPage, modifier = Modifier.fillMaxWidth()) {
                tabs.forEachIndexed { index, title ->
                    Tab(
                        selected = pagerState.currentPage == index,
                        onClick = { coroutine.launch { pagerState.scrollToPage(index) } },
                        text = { Text(title, color = if (pagerState.currentPage == index) AppTokens.Colors.primary else AppTokens.Colors.onSurface) }
                    )
                }
            }
            HorizontalPager(state = pagerState, modifier = Modifier.weight(1f)) { page ->
                when (page) {
                    0 -> OverviewPage()
                    1 -> RankingPage()
                    2 -> StatsPage()
                }
            }
        }
    }
}

@Composable
fun OverviewPage() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(AppTokens.Spacing.lg),
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text("Today's Steps: 8452", style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.onSurface)
        Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
        Button(
            onClick = {},
            shape = AppTokens.Shapes.large,
            colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
            modifier = Modifier.fillMaxWidth(0.6f).height(48.dp)
        ) {
            Text("Sync Device", style = MaterialTheme.typography.titleMedium)
        }
    }
}

@Composable
fun RankingPage() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(AppTokens.Spacing.lg),
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
    ) {
        repeat(5) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium)
                    .padding(AppTokens.Spacing.md),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text("User ${it + 1}", color = AppTokens.Colors.onSurface)
                Text("${9000 - it * 500} steps", color = AppTokens.Colors.onSurface)
            }
        }
    }
}

@Composable
fun StatsPage() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(AppTokens.Spacing.lg),
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text("Weekly Progress", style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.onSurface)
        repeat(7) {
            Row(
                modifier = Modifier.fillMaxWidth().height(20.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.small)
            ) {
                Box(
                    modifier = Modifier
                        .fillMaxWidth((0.3f + it * 0.1f).coerceAtMost(1f))
                        .background(AppTokens.Colors.primary, AppTokens.Shapes.small)
                )
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
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF9FAFB)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
