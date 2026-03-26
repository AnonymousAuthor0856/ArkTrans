package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        // Configure Immersive Mode: Hide Status Bar and Navigation Bar
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            TeaMasterTheme {
                // Ensure the status bar hiding persists during recomposition
                SideEffect {
                    windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
                }

                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = Color.White
                ) {
                    TeaBrewingScreen()
                }
            }
        }
    }
}

// --- Domain Models ---
data class TeaPreset(
    val name: String,
    val temp: String,
    val time: String,
    val description: String
)

// --- Sample Data ---
val teaPresets = listOf(
    TeaPreset("Sencha", "70°C", "1-2 min", "Japanese green tea, grassy and fresh."),
    TeaPreset("Earl Grey", "98°C", "3-4 min", "Black tea flavored with bergamot oil."),
    TeaPreset("Oolong", "85°C", "3-5 min", "Traditional semi-oxidized Chinese tea."),
    TeaPreset("Chamomile", "100°C", "5 min", "Herbal infusion, calming and caffeine-free."),
    TeaPreset("Matcha", "80°C", "Whisk", "Finely ground powder of green tea leaves.")
)

// --- UI Components ---

@Composable
fun TeaBrewingScreen() {
    // State to track selected tea
    var selectedTea by remember { mutableStateOf(teaPresets[0]) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Header
        HeaderSection()

        Spacer(modifier = Modifier.height(32.dp))

        // Visualization Circle
        BrewingVisualizer(tea = selectedTea)

        Spacer(modifier = Modifier.height(40.dp))

        // Stats Row
        BrewStatsRow(tea = selectedTea)

        Spacer(modifier = Modifier.height(40.dp))

        // Selection List
        TeaSelector(
            presets = teaPresets,
            selected = selectedTea,
            onSelect = { selectedTea = it }
        )

        Spacer(modifier = Modifier.weight(1f))

        // Action Button
        StartBrewButton()
    }
}

@Composable
fun HeaderSection() {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column {
            Text(
                text = "Tea Master",
                style = MaterialTheme.typography.headlineMedium,
                color = Color.Black,
                fontWeight = FontWeight.Bold
            )
            Text(
                text = "Perfect brew, every time",
                style = MaterialTheme.typography.bodySmall,
                color = Color.Gray
            )
        }
        IconButton(onClick = { /* No-op */ }) {
            Icon(
                imageVector = Icons.Default.Settings,
                contentDescription = "Settings",
                tint = Color.Black
            )
        }
    }
}

@Composable
fun BrewingVisualizer(tea: TeaPreset) {
    Box(
        contentAlignment = Alignment.Center,
        modifier = Modifier
            .size(220.dp)
            //.border(width = 1.dp, color = Color(0xFFEEEEEE), shape = CircleShape)
    ) {
        // Inner Circle
        Box(
            modifier = Modifier
                .size(180.dp)
                .clip(CircleShape)
                .background(Color(0xFFF5F5F5)), // Very light grey instead of gradient
            contentAlignment = Alignment.Center
        ) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Icon(
                    imageVector = Icons.Default.Favorite, // Using Heart to represent the "Soul" of tea
                    contentDescription = null,
                    tint = Color(0xFF8D6E63), // Tea brown color
                    modifier = Modifier.size(48.dp)
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = tea.name,
                    style = MaterialTheme.typography.titleLarge,
                    color = Color.Black,
                    fontWeight = FontWeight.SemiBold
                )
            }
        }
    }
}

@Composable
fun BrewStatsRow(tea: TeaPreset) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceEvenly
    ) {
        InfoItem(label = "TEMP", value = tea.temp)
        VerticalDivider()
        InfoItem(label = "TIME", value = tea.time)
        VerticalDivider()
        InfoItem(label = "AMOUNT", value = "250ml")
    }
}

@Composable
fun VerticalDivider() {
    Box(
        modifier = Modifier
            .height(40.dp)
            .width(1.dp)
            .background(Color(0xFFE0E0E0))
    )
}

@Composable
fun InfoItem(label: String, value: String) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Text(
            text = label,
            style = MaterialTheme.typography.labelSmall,
            color = Color.Gray,
            fontWeight = FontWeight.Bold,
            letterSpacing = 1.sp
        )
        Spacer(modifier = Modifier.height(4.dp))
        Text(
            text = value,
            style = MaterialTheme.typography.titleMedium,
            color = Color.Black,
            fontWeight = FontWeight.Medium
        )
    }
}

@Composable
fun TeaSelector(
    presets: List<TeaPreset>,
    selected: TeaPreset,
    onSelect: (TeaPreset) -> Unit
) {
    Column(modifier = Modifier.fillMaxWidth()) {
        Text(
            text = "Select Variety",
            style = MaterialTheme.typography.titleSmall,
            color = Color.Black,
            modifier = Modifier.padding(start = 4.dp, bottom = 12.dp)
        )
        LazyRow(
            horizontalArrangement = Arrangement.spacedBy(12.dp),
            contentPadding = PaddingValues(horizontal = 4.dp)
        ) {
            items(presets) { preset ->
                TeaChip(
                    preset = preset,
                    isSelected = preset == selected,
                    onClick = { onSelect(preset) }
                )
            }
        }
    }
}

@Composable
fun TeaChip(
    preset: TeaPreset,
    isSelected: Boolean,
    onClick: () -> Unit
) {
    val containerColor = if (isSelected) Color.Black else Color.White
    val contentColor = if (isSelected) Color.White else Color.Black
    val borderColor = if (isSelected) Color.Black else Color(0xFFE0E0E0)

    Card(
        shape = RoundedCornerShape(50), // Pill shape
        border = BorderStroke(1.dp, borderColor),
        colors = CardDefaults.cardColors(containerColor = containerColor),
        modifier = Modifier
            .clickable { onClick() }
    ) {
        Box(
            modifier = Modifier.padding(horizontal = 20.dp, vertical = 10.dp),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = preset.name,
                style = MaterialTheme.typography.bodyMedium,
                color = contentColor,
                fontWeight = if (isSelected) FontWeight.Bold else FontWeight.Normal
            )
        }
    }
}

@Composable
fun StartBrewButton() {
    Button(
        onClick = { /* No-op */ },
        modifier = Modifier
            .fillMaxWidth()
            .height(56.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = Color.Black,
            contentColor = Color.White
        ),
        shape = RoundedCornerShape(16.dp),
        elevation = ButtonDefaults.buttonElevation(defaultElevation = 0.dp)
    ) {
        Icon(
            imageVector = Icons.Default.PlayArrow,
            contentDescription = null,
            modifier = Modifier.size(20.dp)
        )
        Spacer(modifier = Modifier.width(8.dp))
        Text(
            text = "START TIMER",
            style = MaterialTheme.typography.titleSmall,
            fontWeight = FontWeight.Bold
        )
    }
}

// Helper for border modifier without shape arg in older compose versions,
// strictly creating a shape based border.


// --- Theme Wrapper ---
@Composable
fun TeaMasterTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = androidx.compose.material3.lightColorScheme(
            primary = Color.Black,
            onPrimary = Color.White,
            background = Color.White,
            onBackground = Color.Black,
            surface = Color.White,
            onSurface = Color.Black
        ),
        content = content
    )
}

@Preview(showBackground = true, widthDp = 360, heightDp = 800)
@Composable
fun DefaultPreview() {
    TeaMasterTheme {
        TeaBrewingScreen()
    }
}