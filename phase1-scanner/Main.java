import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        if (args.length < 4) {
            System.out.println("Usage: java Main -i <input> -o <output>");
            return;
        }
        String input_file_name = args[1];
        String output_file_name = args[3];

        String outputPath = "out/" + output_file_name;
        String reportPath = "report/" + output_file_name.replaceFirst("\\.out", ".report.txt");
        createFile(outputPath);
        createFile(reportPath);

        String[] lines = {
                "class",
                "T_ID Program",
                "{",
                "void",
                "T_ID main",
                "(",
                ")",
                "{",
                "}",
                "}"
        };

        writeContentToFile(outputPath, lines);
    }

    private static boolean createFile(String path) {
        File file = new File(path);
        try {
            return file.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static void writeContentToFile(String path, String[] lines) {
        try (FileWriter writer = new FileWriter(new File(path))) {
            String content = String.join("\n", lines);
            writer.write(content);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}