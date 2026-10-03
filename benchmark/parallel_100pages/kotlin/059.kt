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
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
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

private const val NAME = "088_MedicineReminder_en"
private const val UI_TYPE = "Health ListDetail"
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

data class Medicine(val id: Int, val name: String, val time: String)

@Composable
fun MedicineItem(m: Medicine) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(AppTokens.Colors.surface, AppTokens.Shapes.medium)
            .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
            .padding(AppTokens.Spacing.md),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
            Text(m.name, style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
            Text(m.time, style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
        }
        Box(
            modifier = Modifier
                .size(16.dp)
                .background(AppTokens.Colors.primary, CircleShape)
        )
    }
}

@Composable
fun MedicineList() {
    val items = listOf(
        Medicine(1, "Vitamin C", "08:00 AM"),
        Medicine(2, "Aspirin", "12:30 PM"),
        Medicine(3, "Insulin", "06:00 PM"),
        Medicine(4, "Melatonin", "10:00 PM")
    )
    LazyColumn(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
        contentPadding = androidx.compose.foundation.layout.PaddingValues(bottom = AppTokens.Spacing.xxl)
    ) {
        items(items) { m -> MedicineItem(m) }
    }
}

@Composable
fun RootScreen() {
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        floatingActionButton = {
            FloatingActionButton(
                onClick = {},
                containerColor = AppTokens.Colors.primary,
                contentColor = AppTokens.Colors.onPrimary,
                shape = CircleShape
            ) {
                Text("+", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onPrimary)
            }
        },
        bottomBar = {
            BottomAppBar(
                containerColor = AppTokens.Colors.surface,
                contentColor = AppTokens.Colors.onSurface,
                tonalElevation = AppTokens.ElevationMapping.level2.elevation
            ) {
                Row(
                    modifier = Modifier.fillMaxWidth().padding(horizontal = AppTokens.Spacing.lg),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text("Today", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.primary)
                    Text("History", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
                    Text("Profile", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
                }
            }
        },
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
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text("Medicine Reminder", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onBackground)
            MedicineList()
            Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
            Button(
                onClick = {},
                modifier = Modifier.fillMaxWidth(0.8f).height(48.dp),
                shape = AppTokens.Shapes.large,
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary, contentColor = AppTokens.Colors.onSecondary)
            ) {
                Text("Mark All Taken", style = MaterialTheme.typography.titleMedium)
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
